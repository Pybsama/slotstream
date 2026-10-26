import Foundation
import Metal
import MLX
import Cmlx
import CNativeSchedule

/// A prepared native Metal schedule of the grouped expert kernels. The plan
/// owns pipelines, never model weights or request state. A submitted command
/// retains its buffers until completion; the returned MLX array owns its
/// output independently. This is the same arithmetic as NativeExpertTiles.
/// Inspired by Splash's CommandGraph/ExecutionPlans (Apache-2.0).
package final class NativeExpertSchedule {
    // Prepared sections preserve the qualified MPP arithmetic and use MLX's
    // existing stream. Older devices retain the established execution path.
    // The environment switches are internal ablation controls, not app choices.
    package static let enabled = Q2PackedExperts.enabled
        && ProcessInfo.processInfo.environment["SLOTSTREAM_NATIVE_EXPERT_SCHEDULE"] != "0"
    package static let gpuStagingEnabled = enabled
        && ProcessInfo.processInfo.environment["SLOTSTREAM_NATIVE_GPU_STAGING"] != "0"
    // Eight maintained Q2 verify rows, ten routes each, three original Q2
    // pieces per expert. Charged separately before expert-cache sizing.
    package static let gpuStagingReserveBytes = 110_592_000
    package static var eventStats: (created: UInt64, reused: UInt64, cached: UInt64) {
        var created: UInt64 = 0, reused: UInt64 = 0, cached: UInt64 = 0
        ss_schedule_event_stats(&created, &reused, &cached)
        return (created, reused, cached)
    }
    private struct Key: Hashable { let hidden: Int, intermediate: Int; let affine: Bool; let mixedShared: Bool }
    private static let lock = NSLock()
    private static var plans: [Key: NativeExpertSchedule] = [:]
    private static var groupedSubmissions = 0
    private static var mixedSubmissions = 0
    package static var mixedSubmissionCount: Int { lock.withLock { mixedSubmissions } }
    package static var groupedSubmissionCount: Int { lock.withLock { groupedSubmissions } }
    package static let earlySubmission = ProcessInfo.processInfo.environment["SLOTSTREAM_NATIVE_EXPERT_PRELAUNCH"] != "0"
    private let device: MTLDevice
    private var nativePlan: UnsafeMutableRawPointer!
    private let gather: MTLComputePipelineState, gateUp: MTLComputePipelineState
    private let down: MTLComputePipelineState, scatter: MTLComputePipelineState
    private let hidden: Int, intermediate: Int
    private let affine: Bool
    private let mixedShared: Bool

    package static func plan(hidden: Int, intermediate: Int, affine: Bool, mixedShared: Bool = false) throws -> NativeExpertSchedule {
        try lock.withLock {
            let key = Key(hidden: hidden, intermediate: intermediate, affine: affine, mixedShared: mixedShared)
            if let plan = plans[key] { return plan }
            guard Q2PackedExperts.enabled, (64...8192).contains(hidden), (64...16384).contains(intermediate),
                  hidden.isMultiple(of: 64), intermediate.isMultiple(of: 64),
                  (!mixedShared || (!affine && hidden == 2560 && intermediate == 640)), plans.count < 16 else { throw ModelError("Unsupported native expert schedule") }
            let plan = try NativeExpertSchedule(hidden: hidden, intermediate: intermediate, affine: affine, mixedShared: mixedShared)
            plans[key] = plan
            return plan
        }
    }

    private init(hidden: Int, intermediate: Int, affine: Bool, mixedShared: Bool) throws {
        guard let device = MTLCreateSystemDefaultDevice() else {
            throw ModelError("Native expert schedule cannot find a Metal device")
        }
        self.device = device
        self.hidden = hidden; self.intermediate = intermediate; self.affine = affine; self.mixedShared = mixedShared
        func projection(_ name: String, input: Int, output: Int, fused: Bool) -> String {
            """
            #define IN \(input)
            #define OUT \(output)
            #define FUSED \(fused ? "true" : "false")
            #define AFFINE \(affine ? "true" : "false")
            kernel void \(name)(device const bfloat* x [[buffer(0)]],
                device const uchar* w [[buffer(1)]], device const uchar* scales [[buffer(2)]],
                device const uchar* biases [[buffer(3)]], device const uchar* up [[buffer(4)]],
                device const uchar* up_scales [[buffer(5)]], device const uchar* up_biases [[buffer(6)]],
                device const int* slots [[buffer(7)]], device const int* live [[buffer(8)]],
                device bfloat* y [[buffer(9)]], device const uint* ready [[buffer(10)]], uint3 threadgroup_position_in_grid [[threadgroup_position_in_grid]],
                uint thread_index_in_simdgroup [[thread_index_in_simdgroup]],
                uint simdgroup_index_in_threadgroup [[simdgroup_index_in_threadgroup]],
                uint thread_index_in_threadgroup [[thread_index_in_threadgroup]]\(mixedShared ? ", device const uchar* shared_gate [[buffer(11)]], device const uchar* shared_up [[buffer(12)]], device const uchar* shared_down [[buffer(13)]], device const uint* shared_meta [[buffer(14)]], constant uint& shared_tile [[buffer(15)]]" : "")) {
                if (*ready != 1 || live[threadgroup_position_in_grid.y] == 0) return;
                \(mixedShared ? "threadgroup half schedule_stage[2*2*32*32];threadgroup half2 schedule_tables[2*256];if(threadgroup_position_in_grid.y==shared_tile){" + NativeSharedExpertTiles.mixedSource + "return;}" : "")
                \(mixedShared ? NativeExpertTiles.source.replacingOccurrences(of: "threadgroup half stage[2*2*32*32];", with: "threadgroup half* stage=schedule_stage;") : NativeExpertTiles.source)
            }
            #undef IN
            #undef OUT
            #undef FUSED
            #undef AFFINE
            """ + "\n"
        }
        let source = "#include <metal_stdlib>\nusing namespace metal;\n" + NativeExpertTiles.header
            + (mixedShared ? NativeSharedExpertTiles.header + "\n" + NativeSharedExpertTiles.mixedHeader + "\n" : "")
            + projection("native_gate_up", input: hidden, output: intermediate, fused: true)
            + projection("native_down", input: intermediate, output: hidden, fused: false)
            + """
            kernel void native_gather(device const bfloat* x [[buffer(0)]], device const int* order [[buffer(1)]],
                device bfloat* y [[buffer(2)]], constant uint& count [[buffer(3)]], device const uint* ready [[buffer(4)]], uint i [[thread_position_in_grid]]) {
                if (*ready != 1) return;
                if (i < count) y[i] = x[size_t(order[i / \(hidden)]) * \(hidden) + i % \(hidden)];
            }
            kernel void native_scatter(device const bfloat* x [[buffer(0)]], device const int* inverse [[buffer(1)]],
                device bfloat* y [[buffer(2)]], constant uint& count [[buffer(3)]], device const uint* ready [[buffer(4)]], uint i [[thread_position_in_grid]]) {
                if (*ready != 1) return;
                if (i < count) y[i] = x[size_t(inverse[i / \(hidden)]) * \(hidden) + i % \(hidden)];
            }
            """
            + (affine ? "" : Self.repackSource(hidden: hidden, intermediate: intermediate))
        let options = MTLCompileOptions()
        // Expert products retain explicit accumulation order and precision
        // boundaries. Qualify the upstream compiler mode against the
        // independent compressed-byte oracle and fallback schedule.
        if #available(macOS 15.0, *) { options.mathMode = .fast }
        else { options.fastMathEnabled = false }
        let library = try device.makeLibrary(source: source, options: options)
        func pipeline(_ name: String) throws -> MTLComputePipelineState {
            guard let function = library.makeFunction(name: name) else { throw ModelError("Missing native expert kernel") }
            return try device.makeComputePipelineState(function: function)
        }
        gather = try pipeline("native_gather"); gateUp = try pipeline("native_gate_up")
        down = try pipeline("native_down"); scatter = try pipeline("native_scatter")
        func pointer(_ value: MTLComputePipelineState) -> UnsafeMutableRawPointer {
            Unmanaged.passUnretained(value as AnyObject).toOpaque()
        }
        let repack = affine ? nil : try pipeline("native_repack")
        // The plan retains the pipeline before this local reference expires.
        nativePlan = withExtendedLifetime(repack) {
            ss_schedule_plan(pointer(gather), pointer(gateUp), pointer(down), pointer(scatter),
                Int32(hidden), Int32(intermediate), affine, repack.map(pointer), mixedShared)
        }
        guard nativePlan != nil else { throw ModelError(String(cString: ss_schedule_error())) }
    }

    deinit { ss_schedule_plan_free(nativePlan) }

    /// Same lossless tile layout as Q2PackedExperts, writing only the pinned
    /// destinations whose private host reads completed. Raw forecast tickets
    /// share the batch; previously prepared adoptions keep their mask unset.
    private static func repackSource(hidden: Int, intermediate: Int) -> String {
        """
        template<uint N,uint K>
        inline void native_repack_piece(device const uchar* raw, device uchar* packed,
            device const int* slots, device const int* filled, device const uint* ready,
            device const uchar* forecast, device const int* sources, uint2 position) {
            uint i=position.x;
            if(i>=N*K/64 || ready[0]!=1)return;
            for(uint expert=position.y;expert<ready[1];expert+=4) {
                if(filled[expert]==0)continue;
                bool predicted=filled[expert]==2;
                device const uchar* input=predicted?forecast:raw;
                uint row=i/(K/64), block=i%(K/64);
                size_t source=size_t(predicted?sources[expert]:expert)*N*K/64*18+size_t(i)*18;
                size_t base=size_t(slots[expert])*N*K/64*18;
                for(uint part=0;part<2;++part) {
                    size_t to=base+((size_t(row/64)*(K/32)+2*block+part)*64+row%64)*8;
                    for(uint b=0;b<8;++b)packed[to+b]=input[source+2+part*8+b];
                }
                size_t scale=base+N*K/4+((size_t(row/64)*(K/64)+block)*64+row%64)*2;
                packed[scale]=input[source];packed[scale+1]=input[source+1];
            }
        }
        kernel void native_repack(device const uchar* raw_gate [[buffer(0)]],
            device const uchar* raw_up [[buffer(1)]], device const uchar* raw_down [[buffer(2)]],
            device uchar* packed_gate [[buffer(3)]], device uchar* packed_up [[buffer(4)]],
            device uchar* packed_down [[buffer(5)]], device const int* slots [[buffer(6)]],
            device const int* filled [[buffer(7)]], device const uint* ready [[buffer(8)]],
            device const uchar* forecast_gate [[buffer(9)]], device const uchar* forecast_up [[buffer(10)]],
            device const uchar* forecast_down [[buffer(11)]], device const int* sources [[buffer(12)]],
            uint3 position [[thread_position_in_grid]]) {
            // Each piece has the same element count. Specialize its dimensions
            // so combining the grids does not introduce dynamic integer division.
            uint piece=position.z;
            if(piece==2) {
                native_repack_piece<\(hidden),\(intermediate)>(raw_down,packed_down,
                    slots,filled,ready,forecast_down,sources,position.xy);
            } else {
                native_repack_piece<\(intermediate),\(hidden)>(piece==0?raw_gate:raw_up,
                    piece==0?packed_gate:packed_up,slots,filled,ready,
                    piece==0?forecast_gate:forecast_up,sources,position.xy);
            }
        }

        """
    }

    /// The shared expert uses resident prepared weights, passed on every
    /// invocation. No plan retains them or a prior request's inputs.
    package struct SharedBindings {
        let weights: [Q2ResidentWeights]
        package init?(gate: Q2GGUFLinear, up: Q2GGUFLinear, down: Q2GGUFLinear) {
            let linears: [Q2GGUFLinear] = [gate,up,down]
            guard linears.allSatisfy({ $0.inputOrder == nil && $0.outputOrder == nil
                && $0.inputType == .bfloat16 && $0.outputType == .bfloat16 }),
                let g=gate.prepared, let u=up.prepared, let d=down.prepared,
                g.columns == 2560, u.columns == 2560, g.rows == 640, u.rows == 640,
                d.columns == 640, d.rows == 2560,
                [g,u,d].allSatisfy({ Q2ResidentWeights.decoder($0.format) != nil }) else { return nil }
            weights=[g,u,d]
        }
        fileprivate func arrays(count: Int) -> [MLXArray] {
            var metadata=weights.flatMap { [UInt32($0.format.rawValue),UInt32($0.plane1),UInt32($0.meta)] }
            metadata.append(UInt32(count))
            return weights.map(\.bytes)+[MLXArray(metadata)]
        }
    }

    /// Retain distinct array handles for one cache allocation. The extension
    /// binds MLX's buffers directly, without registering no-copy Metal views.
    package final class Bindings {
        fileprivate let owners: [MLXArray]
        fileprivate let records: Int, hidden: Int, intermediate: Int
        fileprivate let affine: Bool
        fileprivate init(owners: [MLXArray], records: Int, hidden: Int, intermediate: Int, affine: Bool) {
            self.owners = owners; self.records = records; self.hidden = hidden
            self.intermediate = intermediate; self.affine = affine
        }
    }
    package func bind(_ weights: [MLXArray]) throws -> Bindings {
        guard weights.count == (affine ? 9 : 3), weights[0].ndim > 0,
              (1...65536).contains(weights[0].dim(0)) else { throw ModelError("Invalid expert weight bindings") }
        let records = weights[0].dim(0)
        for (i, weight) in weights.enumerated() {
            let piece = affine ? i / 3 : i, metadata = affine && i % 3 != 0
            let n = piece == 2 ? hidden : intermediate, k = piece == 2 ? intermediate : hidden
            let bytes = affine ? n * k / (metadata ? 32 : 2) : n * k / 64 * 18
            guard weight.ndim > 0, weight.dim(0) == records, weight.nbytes == records * bytes else {
                throw ModelError("Native expert schedule weight extent differs")
            }
            let view = weight.asData(access: .noCopy)
            var stride = 1
            for dimension in weight.shape.indices.reversed() {
                guard weight.shape[dimension] == 1 || view.strides[dimension] == stride else {
                    throw ModelError("Native expert schedule requires contiguous weights")
                }
                stride *= weight.shape[dimension]
            }
        }
        return Bindings(owners: weights.map { $0.reshaped($0.shape) }, records: records,
            hidden: hidden, intermediate: intermediate, affine: affine)
    }
    package func apply(_ input: MLXArray, weights: [MLXArray], ids: [Int32], repeatInput: Int) throws -> MLXArray {
        try submit(input, weights: weights, ids: ids, repeatInput: repeatInput, awaitingReads: false).value()
    }
    package func submit(_ input: MLXArray, weights: [MLXArray], ids: [Int32], repeatInput: Int,
                        awaitingReads: Bool, groupedOutput: Bool = false) throws -> Pending {
        try submit(input, bindings: bind(weights), ids: ids, repeatInput: repeatInput, awaitingReads: awaitingReads, groupedOutput: groupedOutput)
    }
    /// Enqueue on MLX's own stream before CPU demand reads. The primitive's
    /// event gates all expert kernels. Successful publication does not wait
    /// for GPU completion: following MLX work retains its normal dependencies.
    package func submit(_ input: MLXArray, bindings: Bindings, ids: [Int32], repeatInput: Int,
                        awaitingReads: Bool, groupedOutput: Bool = false, stagedSlots: [Int] = [], prerequisite: MLXArray? = nil,
                        forecastArena: NativeForecastArena? = nil, shared: SharedBindings? = nil) throws -> Pending {
        try autoreleasepool {
            guard !ids.isEmpty, ids.count <= 256, repeatInput > 0, ids.count.isMultiple(of: repeatInput),
                  input.dtype == .bfloat16, input.size == ids.count / repeatInput * hidden,
                  bindings.hidden == hidden, bindings.intermediate == intermediate, bindings.affine == affine,
                  ids.allSatisfy({ $0 >= 0 && $0 < bindings.records }) else {
                throw ModelError("Invalid native expert schedule input")
            }
            guard stagedSlots.isEmpty || (!affine && awaitingReads && stagedSlots.count <= 80
                && stagedSlots.count * 3 * hidden * intermediate / 64 * 18 <= Self.gpuStagingReserveBytes) else {
                throw ModelError("Native expert staging exceeds the bounded Q2 geometry")
            }
            let grouping = NativeExpertTiles.Grouping(ids: ids)
            let count = input.size / hidden
            guard mixedShared == (shared != nil), !mixedShared || (groupedOutput && (1...8).contains(count)) else {
                throw ModelError("Invalid shared expert schedule binding")
            }
            var order = grouping.order.map { $0 / Int32(repeatInput) }
            var experts = grouping.experts, counts = grouping.counts
            if mixedShared {
                order += (0..<8).map { Int32(min($0,count-1)) }
                experts.append(0); counts.append(Int32(count))
            }
            let x = contiguous(input)
            let sharedOwners = shared?.arrays(count: count) ?? []
            defer { withExtendedLifetime(sharedOwners) {} }
            let weightOwners = bindings.owners + sharedOwners
            let stream = StreamOrDevice.default
            var output: UnsafeMutableRawPointer?, job: UnsafeMutableRawPointer?
            // Context pointers do not retain their Swift wrappers. Keep every
            // owner alive until C++ has copied the arrays for asynchronous use.
            let result = withExtendedLifetime((x, weightOwners, prerequisite, forecastArena, stream)) {
                ss_schedule_prepare(nativePlan, x.ctx.ctx, weightOwners.map { $0.ctx.ctx }, Int32(weightOwners.count),
                    order, Int32(order.count), grouping.inverse, Int32(ids.count), experts, counts,
                    stagedSlots.map(Int32.init), Int32(stagedSlots.count), awaitingReads, groupedOutput,
                    prerequisite?.ctx.ctx, forecastArena?.arrays.map { $0.ctx.ctx },
                    stream.ctx.ctx, &output, &job)
            }
            guard result == 0, let output, let job else { throw ModelError(String(cString: ss_schedule_error())) }
            let value = MLXArray(mlx_array(ctx: output))
            let pending = try Pending(output: value, job: job, stagedSlots: stagedSlots, forecastArena: forecastArena,
                inverse: groupedOutput ? grouping.inverse : nil, sharedRows: mixedShared ? count : 0)
            if !awaitingReads { ss_schedule_publish(job, true) }
            // Submit actual routed work while the host constructs
            // the following resident block. Existing cache pins and MLX own
            // its complete lifetime, with no busy loop or extra arithmetic.
            if awaitingReads || Self.earlySubmission { asyncEval(value) }
            if groupedOutput { Self.lock.withLock { Self.groupedSubmissions += 1; if mixedShared { Self.mixedSubmissions += 1 } } }
            return pending
        }
    }
    fileprivate final class Ticket {
        let handle: UnsafeMutableRawPointer
        private let owned: Bool
        init(_ handle: UnsafeMutableRawPointer, owned: Bool = true) { self.handle = handle; self.owned = owned }
        deinit { if owned { ss_schedule_job_free(handle) } }
    }
    package final class Staging {
        private let ticket: Ticket
        package let bases: [UnsafeMutableRawPointer]
        private let index: [Int: Int]
        private let forecastArena: NativeForecastArena?
        package private(set) var copiedSlots = Set<Int>()
        package private(set) var forecastSlots = Set<Int>()
        fileprivate init(ticket: Ticket, slots: [Int], forecastArena: NativeForecastArena?) throws {
            self.ticket = ticket
            self.forecastArena = forecastArena
            index = Dictionary(uniqueKeysWithValues: slots.enumerated().map { ($0.element, $0.offset) })
            bases = try (0..<3).map {
                guard let base = ss_schedule_stage_base(ticket.handle, Int32($0)) else {
                    throw ModelError("Native staging is not host writable")
                }
                return base
            }
        }
        package func indices(for slots: [Int]) throws -> [Int] {
            try slots.map {
                guard let value = index[$0] else { throw ModelError("Unreserved native staging slot") }
                return value
            }
        }
        package func markCopied(_ slots: [Int]) throws {
            let indices = try indices(for: slots).map(Int32.init)
            guard ss_schedule_stage_mark(ticket.handle, indices, Int32(indices.count)) == 0 else {
                throw ModelError(String(cString: ss_schedule_error()))
            }
            copiedSlots.formUnion(slots)
        }
        private final class ReleaseOwner {
            let release: () -> Void
            init(_ release: @escaping () -> Void) { self.release = release }
            deinit { release() }
        }
        /// Returns false without taking ownership when the arena differs.
        package func adoptForecast(_ lease: NativeForecastArena.Lease, slot: Int,
                                   release: @escaping () -> Void) throws -> Bool {
            guard lease.arena === forecastArena else { return false }
            let source = try indices(for: [slot])[0]
            let owner = Unmanaged.passRetained(ReleaseOwner(release))
            let result = ss_schedule_stage_forecast(ticket.handle, Int32(source), Int32(lease.index),
                owner.toOpaque(), { Unmanaged<ReleaseOwner>.fromOpaque($0!).release() })
            guard result == 0 else {
                // C++ takes ownership only on success. The release callback is
                // idempotent at the ticket boundary, including this error path.
                owner.release()
                throw ModelError(String(cString: ss_schedule_error()))
            }
            copiedSlots.insert(slot); forecastSlots.insert(slot)
            return true
        }
    }
    package final class Pending {
        private let output: MLXArray, ticket: Ticket
        package let staging: Staging?
        /// Original route rank to the retained grouped projection row.
        package let inverse: [Int32]?
        private let sharedRows: Int
        package var sharedValue: MLXArray? {
            guard sharedRows > 0 else { return nil }
            return output[(output.dim(0)-8)..<(output.dim(0)-8+sharedRows)].reshaped([1,sharedRows,output.dim(1)])
        }
        private var job: UnsafeMutableRawPointer { ticket.handle }
        private var finished = false
        fileprivate init(output: MLXArray, job: UnsafeMutableRawPointer, stagedSlots: [Int],
                         forecastArena: NativeForecastArena?, inverse: [Int32]?, sharedRows: Int = 0) throws {
            self.output = output; self.inverse = inverse; self.sharedRows = sharedRows; ticket = Ticket(job)
            staging = stagedSlots.isEmpty ? nil : try Staging(ticket: ticket, slots: stagedSlots, forecastArena: forecastArena)
        }
        package func value(afterRelease: (() -> Void)? = nil) throws -> MLXArray {
            guard !finished else { throw ModelError("Native expert command was already consumed") }
            ss_schedule_publish(job, true); finished = true
            afterRelease?()
            return output
        }
        package func cancel() {
            guard !finished else { return }
            autoreleasepool {
                ss_schedule_publish(job, false)
                eval(output) // Drain the aborted work before releasing its cache pins.
                finished = true
            }
        }
        deinit { cancel() }
    }
}
