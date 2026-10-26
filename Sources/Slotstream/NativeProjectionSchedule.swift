import Foundation
import Metal
import MLX
import Cmlx
import CNativeSchedule
import CryptoKit

/// Immutable projection dispatch plans on the current MLX stream. Every
/// tensor is a call argument; cached plans retain no model or request arrays.
package enum NativeProjectionSchedule {
    package static let enabled = Q2PackedExperts.enabled
        && ProcessInfo.processInfo.environment["SLOTSTREAM_NATIVE_PROJECTION_SCHEDULE"] != "0"
    private static let lock = NSLock()
    // The separate Q2 projections need 384 plans over eight verify widths.
    // Whole hyper/shared programs replace those families, with 36 actual
    // shared-format triples. Their full-graph capacity gate must stay below
    // this ceiling; 128 silently truncated the first schedule experiment.
    // Plans retain no weights or request arrays.
    // Requalify physical memory and complete requests when changing it.
    private static let planLimit = 512
    private static var plans: [String: Plan] = [:]
    // Row counts and reduction extents are bounded inline dispatch arguments,
    // not shader source specializations. Plans keep their exact buffer shapes
    // while sharing a pipeline across widths with the same arithmetic tile.
    // This dictionary is accessed only under the plan lock in run/make.
    private static var pipelines: [String: MTLComputePipelineState] = [:]
    private static var reusedPipelines = 0
    private static var failed = Set<String>()
    private static var calls = 0, failures = 0, hyperCalls = 0, sharedCalls = 0, stagedPairs = 0, combinations = 0
    package static var combinationCallCount: Int { lock.withLock { combinations } }
    package static var stagedPairCallCount: Int { lock.withLock { stagedPairs } }
    package static var callCount: Int { lock.withLock { calls } }
    package static var hyperCallCount: Int { lock.withLock { hyperCalls } }
    package static var sharedCallCount: Int { lock.withLock { sharedCalls } }
    package static var planCount: Int { lock.withLock { plans.count } }
    package static var pipelineCount: Int { lock.withLock { pipelines.count } }
    package static var pipelineReuseCount: Int { lock.withLock { reusedPipelines } }
    package static var failureCount: Int { lock.withLock { failures } }

    private struct Buffer {
        let shape: [Int], dtype: DType, output: Bool
        init(_ shape: [Int], _ dtype: DType, output: Bool = false) {
            self.shape = shape; self.dtype = dtype; self.output = output
        }
        var spec: [Int32] {
            let type: Int32
            switch dtype { case .bfloat16: type = 1; case .float32: type = 2
            case .uint8: type = 3; case .int32: type = 4; default: preconditionFailure("Unsupported prepared dtype") }
            precondition((1...3).contains(shape.count))
            return [type, Int32(shape.count)] + (shape + Array(repeating: 1, count: 3 - shape.count)).map(Int32.init) + [output ? 1 : 0]
        }
    }
    private final class Plan {
        let handle: UnsafeMutableRawPointer, outputs: Int
        let device: MTLDevice
        init(inputs: Int, buffers: [Buffer]) throws {
            guard let device = MTLCreateSystemDefaultDevice(),
                  let handle = ss_program_new(Int32(inputs), buffers.flatMap(\.spec), Int32(buffers.count)) else {
                throw ModelError("Cannot create a native projection plan")
            }
            self.device = device; self.handle = handle; outputs = buffers.filter(\.output).count
        }
        deinit { ss_program_free(handle) }
        func add(header: String, body: String, fastMath: Bool = false, parameters: [String], definitions: String,
                 bindings: [Int32], writes: UInt32, grid: [Int32], group: [Int32], constants: [Int32] = []) throws {
            let options = MTLCompileOptions()
            if #available(macOS 15.0, *) { options.mathMode = fastMath ? .fast : .safe }
            else { options.fastMathEnabled = false }
            let parameters = parameters + (constants.isEmpty ? [] : ["constant int* dispatchValues"])
            let arguments = parameters.enumerated().map { "\($0.element) [[buffer(\($0.offset))]]" }
                + ["uint3 thread_position_in_grid [[thread_position_in_grid]]",
                   "uint3 threadgroup_position_in_grid [[threadgroup_position_in_grid]]",
                   "uint thread_index_in_threadgroup [[thread_index_in_threadgroup]]",
                   "uint thread_index_in_simdgroup [[thread_index_in_simdgroup]]",
                   "uint simdgroup_index_in_threadgroup [[simdgroup_index_in_threadgroup]]"]
            let source = "#include <metal_stdlib>\nusing namespace metal;\n" + header
                + "\nkernel void run(" + arguments.joined(separator: ",\n") + ") {\n" + definitions + "\n" + body + "\n}\n"
            let key = String(device.registryID) + ":" + String(fastMath) + ":" + SHA256.hash(data: Data(source.utf8)).map { String(format: "%02x", $0) }.joined()
            let pipeline: MTLComputePipelineState
            if let existing = NativeProjectionSchedule.pipelines[key] {
                pipeline = existing; NativeProjectionSchedule.reusedPipelines += 1
            }
            else {
                guard NativeProjectionSchedule.pipelines.count < NativeProjectionSchedule.planLimit * 4 else { throw ModelError("Native projection pipeline capacity exceeded") }
                let library = try device.makeLibrary(source: source, options: options)
                guard let function = library.makeFunction(name: "run") else { throw ModelError("Missing native projection function") }
                pipeline = try device.makeComputePipelineState(function: function)
                NativeProjectionSchedule.pipelines[key] = pipeline
            }
            guard pipeline.staticThreadgroupMemoryLength <= device.maxThreadgroupMemoryLength else {
                throw ModelError("Native projection exceeds device threadgroup memory")
            }
            let pointer = Unmanaged.passUnretained(pipeline as AnyObject).toOpaque()
            guard ss_program_add(handle, pointer, bindings, Int32(bindings.count), writes, grid, group,
                                 constants, Int32(constants.count)) == 0 else {
                throw ModelError(String(cString: ss_program_error()))
            }
        }
        func seal() throws {
            guard ss_program_seal(handle) == 0 else { throw ModelError(String(cString: ss_program_error())) }
        }
        func apply(_ inputs: [MLXArray]) throws -> [MLXArray] {
            var outputs = [UnsafeMutableRawPointer?](repeating: nil, count: self.outputs)
            // Mapping to raw contexts must not end the Swift tensors' lifetime
            // before C++ copies their MLX arrays into the asynchronous node.
            let stream = StreamOrDevice.default
            let status = withExtendedLifetime((inputs, stream)) {
                ss_program_apply(handle, inputs.map { $0.ctx.ctx }, Int32(inputs.count),
                    stream.ctx.ctx, &outputs, Int32(outputs.count))
            }
            guard status == 0 else {
                throw ModelError(String(cString: ss_program_error()))
            }
            return outputs.map { MLXArray(mlx_array(ctx: $0!)) }
        }
    }
    private static func run(_ key: String, inputs: [MLXArray], make: () throws -> Plan) -> [MLXArray]? {
        guard enabled else { return nil }
        let plan: Plan? = lock.withLock {
            if let plan = plans[key] { return plan }
            guard !failed.contains(key) else { return nil }
            guard plans.count + failed.count < planLimit else {
                failures += 1
                return nil
            }
            do {
                let plan = try autoreleasepool { try make() }
                try plan.seal(); plans[key] = plan; return plan
            }
            catch { failed.insert(key); failures += 1; fputs("Native projection preparation failed: \(error)\n", stderr); return nil }
        }
        guard let plan else { return nil }
        do {
            let result = try plan.apply(inputs)
            lock.withLock {
                calls += 1
                if key.hasPrefix("hyper.") { hyperCalls += 1 }
                if key.hasPrefix("shared.") || key.hasPrefix("sharedStaged.") { sharedCalls += 1 }
                if key.hasPrefix("stagedPair.") { stagedPairs += 1 }
                if key.hasPrefix("combine.") { combinations += 1 }
            }
            return result
        } catch {
            lock.withLock { failures += 1 }
            return nil // Same arithmetic through the established MLX path.
        }
    }
    private static func metalType(_ dtype: DType) -> String? {
        switch dtype { case .bfloat16: return "bfloat"; case .float32: return "float"; default: return nil }
    }
    /// Splash's single combine grid, with the existing native engine's
    /// separate FP32 multiply/add rounding retained. Fresh output ownership
    /// replaces upstream's in-place streams so checkpoints remain immutable.
    package static func combine(_ streams: MLXArray, branch: MLXArray, injection: MLXArray) -> MLXArray? {
        guard streams.ndim == 3, branch.ndim == 3, streams.dim(0) == 1,
              let branchType = metalType(branch.dtype) else { return nil }
        let rows = streams.dim(1), hidden = branch.dim(-1)
        guard (1...8).contains(rows), hidden > 0,
              streams.shape == [1,rows,4*hidden], branch.shape == [1,rows,hidden],
              injection.shape == [1,rows,4], streams.dtype == .float32,
              injection.dtype == .float32 else { return nil }
        let inputs = [contiguous(streams),contiguous(branch),contiguous(injection)]
        return run("combine.\(rows).\(hidden).\(branchType)", inputs: inputs) {
            let p = try Plan(inputs: 3, buffers: inputs.map { Buffer($0.shape,$0.dtype) }
                + [Buffer(streams.shape,.float32,output:true)])
            try p.add(header: "#pragma clang fp reassociate(off)\n#pragma clang fp contract(off)\n",
                body: """
                uint d=thread_position_in_grid.x,row=thread_position_in_grid.y;
                if(d>=\(hidden))return;
                float value=float(branch[row*\(hidden)+d]);
                for(uint s=0;s<4;++s){
                    uint i=row*\(4*hidden)+s*\(hidden)+d;
                    float product=value*weights[row*4+s];
                    output[i]=streams[i]+product;
                }
                """, parameters: ["device const float* streams", "device const \(branchType)* branch",
                    "device const float* weights", "device float* output"], definitions: "",
                bindings: [0,1,2,3], writes: 8, grid: [Int32(hidden),Int32(rows),1], group: [256,1,1])
            return p
        }?.first
    }

    package static func prepare(_ input: MLXArray, rows: Int, columns: Int) -> [MLXArray]? {
        run("prepare.\(rows).\(columns)", inputs: [input]) {
            let p = try Plan(inputs: 1, buffers: [Buffer([rows, columns], .bfloat16),
                Buffer([columns * 8], .bfloat16, output: true), Buffer([columns / 16 * 8 + columns / 32 * 8], .float32, output: true)])
            try p.add(header: Q2RegisterKernelSources.header, body: Q2RegisterKernelSources.prepare,
                parameters: ["device const bfloat* input", "device bfloat* table", "device float* sums"],
                definitions: "constexpr int IN = \(columns);\nconst int COUNT = dispatchValues[0];\n",
                bindings: [0, 1, 2], writes: 6, grid: [Int32(columns / 64 * 8 / 4 * 128), 1, 1], group: [128, 1, 1], constants: [Int32(rows)])
            return p
        }
    }
    package static func register(_ inputs: [MLXArray], format: Q2GGUFFormat, k: Int, n: Int,
                                 rows: Int, splits: Int, p1: Int, meta: Int, dtype: DType) -> MLXArray? {
        guard let type = metalType(dtype), let decoder = Q2ResidentWeights.decoder(format) else { return nil }
        return run("register.\(format.rawValue).\(k).\(n).\(rows).\(splits).\(dtype)", inputs: inputs) {
            let p = try Plan(inputs: 3, buffers: inputs.map { Buffer($0.shape, $0.dtype) }
                + [Buffer([splits, 8, n], .float32), Buffer([rows, n], dtype, output: true)])
            try p.add(header: Q2RegisterKernelSources.header + "\ntypedef \(decoder) F;\n", body: Q2RegisterKernelSources.matrix, fastMath: true,
                parameters: ["device const bfloat* table", "device const float* sums", "device const uchar* w", "device float* y"],
                definitions: "constexpr int IN = \(k);\nconstexpr int OUT = \(n);\nconstexpr int SPLITS = \(splits);\nconstexpr int P1 = \(p1);\nconstexpr int META = \(meta);\n",
                bindings: [0, 1, 2, 3], writes: 8, grid: [Int32(n / 64 * 128), Int32(splits), 1], group: [128, 1, 1])
            try p.add(header: "#pragma clang fp reassociate(off)\n",
                body: "uint i=thread_position_in_grid.x;if(i>=uint(dispatchValues[0]))return;float sum=0;for(uint p=0;p<\(splits);++p)sum+=x[p*\(8 * n)+i];y[i]=\(type)(sum);",
                parameters: ["device const float* x", "device \(type)* y"], definitions: "", bindings: [3, 4], writes: 2,
                grid: [Int32(n * rows), 1, 1], group: [Int32(min(256, n * rows)), 1, 1], constants: [Int32(n * rows)])
            return p
        }?.first
    }
    /// Both matrices read the same prepared activation. Encode the independent
    /// matrix work before either reduction, retaining each matrix's split order
    /// and output rounding. Weights remain arguments, never cached in a plan.
    package static func registerPair(_ input: Q2RegisterProjection.Input,
        first: Q2ResidentWeights, second: Q2ResidentWeights,
        splits: [Int], types: [DType]) -> [MLXArray]? {
        let weights = [first, second]
        guard first.columns == second.columns, input.columns == first.columns,
              splits.count == 2, types.count == 2,
              types.allSatisfy({ metalType($0) != nil }) else { return nil }
        let values = [input.table, input.sums, first.bytes, second.bytes]
        let key = "pair.\(input.rows).\(input.columns)." + weights.indices.map {
            "\(weights[$0].format.rawValue).\(weights[$0].rows).\(splits[$0]).\(types[$0])"
        }.joined(separator: ".")
        return run(key, inputs: values) {
            var buffers = values.map { Buffer($0.shape, $0.dtype) }
            for i in weights.indices {
                buffers += [Buffer([splits[i], 8, weights[i].rows], .float32),
                    Buffer([input.rows, weights[i].rows], types[i], output: true)]
            }
            let p = try Plan(inputs: 4, buffers: buffers)
            for i in weights.indices {
                let w = weights[i]
                guard let decoder = Q2ResidentWeights.decoder(w.format) else {
                    throw ModelError("Unsupported paired resident format")
                }
                try p.add(header: Q2RegisterKernelSources.header + "\ntypedef \(decoder) F;\n",
                    body: Q2RegisterKernelSources.matrix, fastMath: true,
                    parameters: ["device const bfloat* table", "device const float* sums", "device const uchar* w", "device float* y"],
                    definitions: "constexpr int IN = \(w.columns);\nconstexpr int OUT = \(w.rows);\nconstexpr int SPLITS = \(splits[i]);\nconstexpr int P1 = \(w.plane1);\nconstexpr int META = \(w.meta);\n",
                    bindings: [0, 1, Int32(2 + i), Int32(4 + i * 2)], writes: 8,
                    grid: [Int32(w.rows / 64 * 128), Int32(splits[i]), 1], group: [128, 1, 1])
            }
            for i in weights.indices {
                let n = weights[i].rows, type = metalType(types[i])!
                try p.add(header: "#pragma clang fp reassociate(off)\n",
                    body: "uint i=thread_position_in_grid.x;if(i>=uint(dispatchValues[0]))return;float sum=0;for(uint p=0;p<\(splits[i]);++p)sum+=x[p*\(8 * n)+i];y[i]=\(type)(sum);",
                    parameters: ["device const float* x", "device \(type)* y"], definitions: "",
                    bindings: [Int32(4 + i * 2), Int32(5 + i * 2)], writes: 2,
                    grid: [Int32(n * input.rows), 1, 1], group: [Int32(min(256, n * input.rows)), 1, 1], constants: [Int32(n * input.rows)])
            }
            return p
        }
    }
    /// Two wide projections share one dispatch, with each workgroup assigned
    /// one matrix and its original K partition. The optional ordered reductions
    /// share one dispatch too. Scratch and outputs belong to this invocation.
    package static func stagedPair(_ input: MLXArray, first: Q2ResidentWeights,
        second: Q2ResidentWeights, splits: [Int], types: [DType]) -> [MLXArray]? {
        let count = input.size / first.columns, weights = [first, second]
        guard (1...8).contains(count), first.columns == second.columns,
              let inputType = metalType(input.dtype), splits.count == 2, types.count == 2,
              types.allSatisfy({ metalType($0) != nil }), splits.allSatisfy({ $0 > 0 }) else { return nil }
        let values = [contiguous(input.reshaped([count, first.columns])), first.bytes, second.bytes]
        let key = "stagedPair.\(count).\(first.columns).\(inputType)." + weights.indices.map {
            "\(weights[$0].format.rawValue).\(weights[$0].rows).\(splits[$0]).\(types[$0])"
        }.joined(separator: ".")
        return run(key, inputs: values) {
            var buffers = values.map { Buffer($0.shape, $0.dtype) }
                + weights.indices.map { Buffer([count, weights[$0].rows], types[$0], output: true) }
            var destination = [3, 4]
            for i in weights.indices where splits[i] > 1 {
                destination[i] = buffers.count
                buffers.append(Buffer([splits[i], count, weights[i].rows], .float32))
            }
            let p = try Plan(inputs: 3, buffers: buffers)
            var branches: [String] = []
            for i in weights.indices {
                let w = weights[i], type = splits[i] > 1 ? "float" : metalType(types[i])!
                guard let decoder = Q2ResidentWeights.decoder(w.format) else {
                    throw ModelError("Unsupported paired staged format")
                }
                let offset = i == 0 ? 0 : splits[0]
                branches.append("""
                {
                    if(threadgroup_position_in_grid.x*64>=\(w.rows))return;
                    const uint3 native_group=uint3(threadgroup_position_in_grid.xy,threadgroup_position_in_grid.z-\(offset));
                    typedef \(inputType) T; typedef \(type) Y; typedef \(decoder) F;
                    constexpr int IN=\(w.columns),OUT=\(w.rows),PARTS=\(splits[i]),P1=\(w.plane1),META=\(w.meta);
                    constexpr int TILE_ROWS=\(NativeProjectionPolicy.stagedTileRows(batch: count, parts: splits[i], format: w.format));
                    const int x_shape[2]={dispatchValues[0],\(w.columns)};
                    device const uchar* w=w\(i); device \(type)* y=y\(i);
                    \(Q2ResidentKernelSources.matrix.replacingOccurrences(of: "threadgroup_position_in_grid", with: "native_group")
                        .replacingOccurrences(of: "threadgroup half stages[2*2*32*32];threadgroup half2 table[256];", with: "threadgroup half* stages=pair_stages;threadgroup half2* table=pair_table;"))
                }
                """)
            }
            let outputTypes = weights.indices.map { splits[$0] > 1 ? "float" : metalType(types[$0])! }
            try p.add(header: "#include <MetalPerformancePrimitives/MetalPerformancePrimitives.h>\n#pragma clang fp reassociate(off)\n" + Q2ResidentKernelSources.header,
                body: "threadgroup half pair_stages[2*2*32*32];threadgroup half2 pair_table[256];\nif(threadgroup_position_in_grid.z<\(splits[0]))" + branches[0] + "else" + branches[1], fastMath: true,
                parameters: ["device const \(inputType)* x", "device const uchar* w0", "device const uchar* w1",
                    "device \(outputTypes[0])* y0", "device \(outputTypes[1])* y1"], definitions: "",
                bindings: [0, 1, 2, Int32(destination[0]), Int32(destination[1])], writes: 24,
                grid: [Int32(max(first.rows,second.rows)), 1, Int32(splits.reduce(0,+))], group: [64, 1, 1], constants: [Int32(count)])
            let reductions = weights.indices.filter { splits[$0] > 1 }
            if !reductions.isEmpty {
                var parameters: [String] = [], bindings: [Int32] = [], body = "uint i=thread_position_in_grid.x;\n"
                var writes: UInt32 = 0
                for (slot, i) in reductions.enumerated() {
                    let n = weights[i].rows, type = metalType(types[i])!
                    parameters += ["device const float* x\(i)", "device \(type)* y\(i)"]
                    bindings += [Int32(destination[i]), Int32(3+i)]; writes |= 1 << (slot*2+1)
                    body += "if(i<\(n)*uint(dispatchValues[0])){float sum=0;for(uint p=0;p<\(splits[i]);++p)sum+=x\(i)[p*(\(n)*dispatchValues[0])+i];y\(i)[i]=\(type)(sum);}\n"
                }
                let extent = reductions.map { weights[$0].rows * count }.max()!
                try p.add(header: "#pragma clang fp reassociate(off)\n", body: body,
                    parameters: parameters, definitions: "", bindings: bindings, writes: writes,
                    grid: [Int32(extent), 1, 1], group: [Int32(min(256,extent)), 1, 1], constants: [Int32(count)])
            }
            return p
        }
    }
    package static func staged(_ inputs: [MLXArray], format: Q2GGUFFormat, k: Int, n: Int,
                               rows: Int, parts: Int, p1: Int, meta: Int, dtype: DType) -> MLXArray? {
        guard rows <= 8, let inputType = metalType(inputs[0].dtype), let outputType = metalType(dtype),
              let decoder = Q2ResidentWeights.decoder(format) else { return nil }
        let partialType = parts > 1 ? "float" : outputType
        return run("staged.\(format.rawValue).\(k).\(n).\(rows).\(parts).\(inputType).\(dtype)", inputs: inputs) {
            var buffers = inputs.map { Buffer($0.shape, $0.dtype) }
            buffers.append(Buffer(parts > 1 ? [parts, rows, n] : [rows, n], parts > 1 ? .float32 : dtype, output: parts == 1))
            if parts > 1 { buffers.append(Buffer([rows, n], dtype, output: true)) }
            let p = try Plan(inputs: 2, buffers: buffers)
            try p.add(header: "#include <MetalPerformancePrimitives/MetalPerformancePrimitives.h>\n#pragma clang fp reassociate(off)\n"
                + Q2ResidentKernelSources.header + "\ntypedef \(decoder) F;\n",
                body: "const int x_shape[2]={dispatchValues[0],\(k)};\n" + Q2ResidentKernelSources.matrix, fastMath: true,
                parameters: ["device const \(inputType)* x", "device const uchar* w", "device \(partialType)* y"],
                definitions: "typedef \(inputType) T;\ntypedef \(partialType) Y;\nconstexpr int IN = \(k);\nconstexpr int OUT = \(n);\nconstexpr int P1 = \(p1);\nconstexpr int META = \(meta);\nconstexpr int PARTS = \(parts);\nconstexpr int TILE_ROWS=\(NativeProjectionPolicy.stagedTileRows(batch: rows, parts: parts, format: format));\n",
                bindings: [0, 1, 2], writes: 4, grid: [Int32(n), Int32((rows + 7) / 8), Int32(parts)], group: [64, 1, 1], constants: [Int32(rows)])
            if parts > 1 {
                try p.add(header: "#pragma clang fp reassociate(off)\n",
                    body: "uint i=thread_position_in_grid.x;if(i>=uint(dispatchValues[0]))return;float sum=0;for(uint p=0;p<\(parts);++p)sum+=x[p*dispatchValues[0]+i];y[i]=\(outputType)(sum);",
                    parameters: ["device const float* x", "device \(outputType)* y"], definitions: "", bindings: [2, 3], writes: 2,
                    grid: [Int32(rows * n), 1, 1], group: [Int32(min(256, rows * n)), 1, 1], constants: [Int32(rows * n)])
            }
            return p
        }?.first
    }
    /// Keep the resident shared expert's complete topology in one program.
    /// The two register projections keep their independent formats, splits
    /// and BF16 rounding. All weights are invocation arguments. This still
    /// runs before the routed expert's host-ready wait, overlapping its reads.
    package static func shared(_ input: MLXArray, gate: Q2GGUFLinear,
                               up: Q2GGUFLinear, down: Q2GGUFLinear) -> MLXArray? {
        let h = input.dim(-1), count = input.size / h
        let linears = [gate, up, down]
        guard enabled, Q2PackedExperts.enabled, (1...8).contains(count),
              input.dtype == .bfloat16,
              linears.allSatisfy({ $0.inputOrder == nil && $0.outputOrder == nil
                  && $0.inputType == .bfloat16 && $0.outputType == .bfloat16 }),
              let g = gate.prepared, let u = up.prepared, let d = down.prepared,
              g.columns == h, u.columns == h, g.rows == u.rows,
              d.columns == g.rows, d.rows == h,
              NativeProjectionPolicy.useRegister(rows: g.rows, columns: h, batch: count, format: g.format),
              NativeProjectionPolicy.useRegister(rows: u.rows, columns: h, batch: count, format: u.format),
              !NativeProjectionPolicy.useRegister(rows: h, columns: d.columns, batch: count, format: d.format),
              NativeProjectionPolicy.splits(rows: h, columns: d.columns, cores: NativeProjectionPolicy.device.cores,
                  register: false, apple10: NativeProjectionPolicy.device.apple10) == 1,
              let downDecoder = Q2ResidentWeights.decoder(d.format) else { return nil }
        let m = g.rows, weights = [g, u]
        let splits = weights.map {
            NativeProjectionPolicy.splits(rows: $0.rows, columns: $0.columns,
                cores: NativeProjectionPolicy.device.cores, register: true, apple10: true)
        }
        let values = [contiguous(input.reshaped([count, h])), g.bytes, u.bytes, d.bytes]
        let key = "shared.\(h).\(m).\(count).\(g.format.rawValue).\(u.format.rawValue).\(d.format.rawValue).\(splits)"
        return run(key, inputs: values) {
            let p = try Plan(inputs: 4, buffers: values.map { Buffer($0.shape, $0.dtype) } + [
                Buffer([h * 8], .bfloat16), Buffer([h / 16 * 8 + h / 32 * 8], .float32),
                Buffer([splits[0], 8, m], .float32), Buffer([splits[1], 8, m], .float32),
                Buffer([count, m], .bfloat16), Buffer([count, h], .bfloat16, output: true)])
            try p.add(header: Q2RegisterKernelSources.header, body: Q2RegisterKernelSources.prepare,
                parameters: ["device const bfloat* input", "device bfloat* table", "device float* sums"],
                definitions: "constexpr int IN=\(h);const int COUNT=dispatchValues[0];",
                bindings: [0, 4, 5], writes: 6, grid: [Int32(h / 64 * 8 / 4 * 128), 1, 1], group: [128, 1, 1], constants: [Int32(count)])
            for i in weights.indices {
                let w = weights[i]
                guard let decoder = Q2ResidentWeights.decoder(w.format) else {
                    throw ModelError("Unsupported prepared shared format")
                }
                try p.add(header: Q2RegisterKernelSources.header + "\ntypedef \(decoder) F;\n",
                    body: Q2RegisterKernelSources.matrix, fastMath: true,
                    parameters: ["device const bfloat* table", "device const float* sums", "device const uchar* w", "device float* y"],
                    definitions: "constexpr int IN=\(h);constexpr int OUT=\(m);constexpr int SPLITS=\(splits[i]);constexpr int P1=\(w.plane1);constexpr int META=\(w.meta);",
                    bindings: [4, 5, Int32(1 + i), Int32(6 + i)], writes: 8,
                    grid: [Int32(m / 64 * 128), Int32(splits[i]), 1], group: [128, 1, 1])
            }
            // These partial sums are consumed only by the activation. Fuse
            // both reductions with it, retaining each matrix's BF16 rounding
            // explicitly before the established FP32 SwiGLU arithmetic.
            // No persistent workspace or changed accumulation is needed.
            try p.add(header: "#pragma clang fp reassociate(off)\n",
                body: """
                uint i=thread_position_in_grid.x;if(i>=uint(dispatchValues[0]))return;
                float gs=0,us=0;
                for(uint p=0;p<\(splits[0]);++p)gs+=g[p*\(8 * m)+i];
                for(uint p=0;p<\(splits[1]);++p)us+=u[p*\(8 * m)+i];
                float v=float(bfloat(gs)),uv=float(bfloat(us));
                float s=v/(1.0f+fast::exp2(-1.44269504089f*v));
                y[i]=bfloat(s*uv);
                """,
                parameters: ["device const float* g", "device const float* u", "device bfloat* y"],
                definitions: "", bindings: [6, 7, 8], writes: 4,
                grid: [Int32(m * count), 1, 1], group: [Int32(min(256, m * count)), 1, 1], constants: [Int32(m * count)])
            try p.add(header: "#include <MetalPerformancePrimitives/MetalPerformancePrimitives.h>\n#pragma clang fp reassociate(off)\n"
                    + Q2ResidentKernelSources.header + "\ntypedef \(downDecoder) F;\n",
                body: "const int x_shape[2]={dispatchValues[0],\(m)};\n" + Q2ResidentKernelSources.matrix, fastMath: true,
                parameters: ["device const bfloat* x", "device const uchar* w", "device bfloat* y"],
                definitions: "typedef bfloat T;typedef bfloat Y;constexpr int IN=\(m);constexpr int OUT=\(h);constexpr int P1=\(d.plane1);constexpr int META=\(d.meta);constexpr int PARTS=1;constexpr int TILE_ROWS=\(NativeProjectionPolicy.stagedTileRows(batch: count, parts: 1, format: d.format));",
                bindings: [8, 3, 9], writes: 4, grid: [Int32(h), 1, 1], group: [64, 1, 1], constants: [Int32(count)])
            return p
        }?.first?.reshaped(input.shape)
    }

    /// The upstream shared expert uses a column tile for one/two rows and
    /// one M8 staged tile otherwise. Two native dispatches retain those
    /// arithmetic boundaries while keeping useful work ahead of the I/O wait.
    /// Combining this with the routed grid is a separate placement change.
    package static func sharedStaged(_ input: MLXArray, gate: Q2GGUFLinear,
        up: Q2GGUFLinear, down: Q2GGUFLinear) -> MLXArray? {
        let h = input.dim(-1), count = input.size / h
        let linears: [Q2GGUFLinear] = [gate, up, down]
        guard enabled, (1...8).contains(count), input.dtype == .bfloat16,
              linears.allSatisfy({ $0.inputOrder == nil && $0.outputOrder == nil
                  && $0.inputType == .bfloat16 && $0.outputType == .bfloat16 }),
              let g = gate.prepared, let u = up.prepared, let d = down.prepared,
              g.columns == h, u.columns == h, g.rows == u.rows,
              d.columns == g.rows, d.rows == h,
              let gd = Q2ResidentWeights.decoder(g.format), let ud = Q2ResidentWeights.decoder(u.format),
              let dd = Q2ResidentWeights.decoder(d.format) else { return nil }
        let values = [contiguous(input.reshaped([count, h])), g.bytes, u.bytes, d.bytes]
        let key = "sharedStaged.\(h).\(g.rows).\(count).\(g.format.rawValue).\(u.format.rawValue).\(d.format.rawValue)"
        return run(key, inputs: values) {
            let p = try Plan(inputs: 4, buffers: values.map { Buffer($0.shape, $0.dtype) }
                + [Buffer([count, g.rows], .bfloat16), Buffer([count, h], .bfloat16, output: true)])
            for fused in [true, false] {
                let first = fused ? g : d, second = fused ? u : d
                let decoder = fused ? gd : dd, other = fused ? ud : dd
                try p.add(header: NativeSharedExpertTiles.header + "\ntypedef \(decoder) FG;typedef \(other) FU;\n",
                    body: NativeSharedExpertTiles.source.replacingOccurrences(of: "if constexpr(COUNT<=2)", with: "if constexpr(NARROW)"),
                    parameters: ["device const bfloat* x", "device const uchar* w", "device const uchar* u", "device bfloat* y"],
                    definitions: "typedef bfloat Y;constexpr int IN=\(first.columns),OUT=\(first.rows),P1=\(first.plane1),META=\(first.meta),UP1=\(second.plane1),UMETA=\(second.meta);constexpr bool FUSED=\(fused ? "true" : "false"),NARROW=\(count <= 2 ? "true" : "false");const int COUNT=dispatchValues[0];",
                    bindings: fused ? [0,1,2,4] : [4,3,3,5], writes: 8,
                    grid: [Int32(first.rows * (fused ? 2 : 1)),1,1], group: [64,1,1], constants: [Int32(count)])
            }
            return p
        }?.first?.reshaped(input.shape)
    }

    /// The complete maintained Q2 hyper-connection is one prepared program.
    /// Reuse its topology while supplying all weights and request arrays on
    /// each call. FP32 normalization/injection, the register down projection,
    /// BF16 low activation, staged up projection and final mix keep the same
    /// arithmetic and reduction order as their separately scheduled paths.
    package static func hyper(_ hyper: MLXArray, norm: MLXArray, inject: MLXArray?,
                              down: Q2GGUFLinear, up: Q2GGUFLinear, hidden: Int) -> (MLXArray, MLXArray?)? {
        let width = 4 * hidden, count = hyper.size / width
        guard enabled, Q2PackedExperts.enabled, (1...8).contains(count),
              hyper.dim(-1) == width, hidden.isMultiple(of: 256), norm.size == width,
              inject == nil || inject!.shape == [4, width],
              down.inputOrder == nil, down.outputOrder == nil, up.inputOrder == nil, up.outputOrder == nil,
              down.inputType == .bfloat16, up.inputType == .bfloat16,
              down.outputType == .bfloat16, up.outputType == .bfloat16,
              let d = down.prepared, let u = up.prepared,
              d.format == .q80, u.format == .q80,
              d.columns == width, u.columns == d.rows, u.rows == width,
              NativeProjectionPolicy.useRegister(rows: d.rows, columns: d.columns, batch: count, format: d.format),
              !NativeProjectionPolicy.useRegister(rows: u.rows, columns: u.columns, batch: count, format: u.format),
              NativeProjectionPolicy.splits(rows: u.rows, columns: u.columns, cores: NativeProjectionPolicy.device.cores,
                register: false, apple10: NativeProjectionPolicy.device.apple10) == 1 else { return nil }
        let m = d.rows
        let splits = NativeProjectionPolicy.splits(rows: m, columns: width, cores: NativeProjectionPolicy.device.cores,
            register: true, apple10: true)
        let inputs = [contiguous(hyper.asType(.float32).reshaped([count, width])),
            contiguous(norm.asType(.float32)), contiguous((inject ?? norm).asType(.float32)), d.bytes, u.bytes]
        let key = "hyper.\(hidden).\(m).\(count).\(inject != nil).\(splits)"
        guard let values = run(key, inputs: inputs, make: {
            let p = try Plan(inputs: 5, buffers: inputs.map { Buffer($0.shape, $0.dtype) } + [
                Buffer([count, width], .bfloat16), Buffer([count, 4], .float32, output: true),
                Buffer([width * 8], .bfloat16), Buffer([width / 16 * 8 + width / 32 * 8], .float32),
                Buffer([splits, 8, m], .float32), Buffer([count, m], .bfloat16),
                Buffer([count, width], .bfloat16),
                Buffer([count, hidden], .bfloat16, output: true)])
            try p.add(header: "#pragma clang fp reassociate(off)\n", body: Q2HyperConnection.normSource,
                parameters: ["device const float* x", "device const float* norm", "device const float* inject",
                    "device bfloat* normalized", "device float* weights"],
                definitions: "constexpr int H=\(hidden);constexpr bool INJECT=\(inject != nil ? "true" : "false");",
                bindings: [0, 1, 2, 5, 6], writes: 24, grid: [Int32(count * 1024), 1, 1], group: [1024, 1, 1])
            try p.add(header: Q2RegisterKernelSources.header, body: Q2RegisterKernelSources.prepare,
                parameters: ["device const bfloat* input", "device bfloat* table", "device float* sums"],
                definitions: "constexpr int IN=\(width);const int COUNT=dispatchValues[0];",
                bindings: [5, 7, 8], writes: 6, grid: [Int32(width / 64 * 8 / 4 * 128), 1, 1], group: [128, 1, 1], constants: [Int32(count)])
            try p.add(header: Q2RegisterKernelSources.header + "\ntypedef FmtQ80 F;\n", body: Q2RegisterKernelSources.matrix, fastMath: true,
                parameters: ["device const bfloat* table", "device const float* sums", "device const uchar* w", "device float* y"],
                definitions: "constexpr int IN=\(width);constexpr int OUT=\(m);constexpr int SPLITS=\(splits);constexpr int P1=\(d.plane1);constexpr int META=\(d.meta);",
                bindings: [7, 8, 3, 9], writes: 8, grid: [Int32(m / 64 * 128), Int32(splits), 1], group: [128, 1, 1])
            // Match the target's upstream SiLU and explicit BF16 reduction
            // boundary. This is also used by the individual Q2 fallback.
            try p.add(header: "#pragma clang fp reassociate(off)\n",
                body: """
                uint i=thread_position_in_grid.x;if(i>=uint(dispatchValues[0]))return;
                float sum=0;for(uint p=0;p<\(splits);++p)sum+=x[p*\(8 * m)+i];
                float v=float(bfloat(sum))/4.0f;
                y[i]=bfloat(v/(1.0f+fast::exp2(-1.44269504089f*v)));
                """,
                parameters: ["device const float* x", "device bfloat* y"], definitions: "",
                bindings: [9, 10], writes: 2, grid: [Int32(m * count), 1, 1], group: [Int32(min(256, m * count)), 1, 1], constants: [Int32(m * count)])
            try p.add(header: "#include <MetalPerformancePrimitives/MetalPerformancePrimitives.h>\n#pragma clang fp reassociate(off)\n"
                    + Q2ResidentKernelSources.header + "\ntypedef FmtQ80 F;\n",
                body: "const int x_shape[2]={dispatchValues[0],\(m)};\n" + Q2ResidentKernelSources.matrix, fastMath: true,
                parameters: ["device const bfloat* x", "device const uchar* w", "device bfloat* y"],
                definitions: "typedef bfloat T;typedef bfloat Y;constexpr int IN=\(m);constexpr int OUT=\(width);constexpr int P1=\(u.plane1);constexpr int META=\(u.meta);constexpr int PARTS=1;constexpr int TILE_ROWS=\(NativeProjectionPolicy.stagedTileRows(batch: count, parts: 1, format: u.format));",
                bindings: [10, 4, 11], writes: 4, grid: [Int32(width), 1, 1], group: [64, 1, 1], constants: [Int32(count)])
            try p.add(header: "#pragma clang fp reassociate(off)\n", body: Q2HyperConnection.mixSource,
                parameters: ["device const bfloat* x", "device const bfloat* gate", "device bfloat* y"],
                definitions: "constexpr int H=\(hidden);", bindings: [5, 11, 12], writes: 4,
                grid: [Int32(hidden), Int32(count), 1], group: [256, 1, 1])
            return p
        }) else { return nil }
        return (values[1].reshaped(Array(hyper.shape.dropLast()) + [hidden]),
            inject == nil ? nil : values[0].reshaped(Array(hyper.shape.dropLast()) + [4]))
    }
}
