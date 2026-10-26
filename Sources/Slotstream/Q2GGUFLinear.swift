import Foundation
import MLX

/// Packed values remain in their original format, with an optional lossless
/// plane layout. Accumulation is FP32. Hidden projections round once to the
/// activation type; vocabulary scores retain FP32. In particular,
/// Q2_0 scales stay FP16; they are never rounded to affine BF16 scales.
package struct Q2GGUFLinear {
    let bytes: MLXArray
    let format: Q2GGUFFormat
    let rows: Int
    let columns: Int
    let prepared: Q2ResidentWeights?
    var inputOrder: MLXArray?
    package var outputOrder: MLXArray?
    /// Vocabulary scores stay FP32 through selection, as in Splash. Hidden
    /// projections retain the activation dtype and its established rounding.
    package var outputType: DType?
    package var inputType: DType?

    package init(bytes: MLXArray, format: Q2GGUFFormat, rows: Int, columns: Int, prepare: Bool = false) {
        prepared = prepare ? Q2ResidentWeights(raw: bytes, format: format, rows: rows, columns: columns) : nil
        self.bytes = prepared?.bytes ?? bytes
        self.format = format; self.rows = rows; self.columns = columns
    }

    package func callAsFunction(_ x: MLXArray) -> MLXArray {
        let typed = inputType.map { x.asType($0) } ?? x
        let input = inputOrder.map { take(typed, $0, axis: -1) } ?? typed
        let n = input.size / columns
        let ids = MLXArray.zeros([n], dtype: .int32)
        let resultType = outputType ?? x.dtype
        let projected: MLXArray
        if let prepared {
            projected = prepared(input, outputType: resultType)
        } else if n >= 2 {
            projected = Kernels.shared.get(format).matmul([contiguous(input.reshaped([n, columns])), contiguous(bytes)],
                template: [("T", input.dtype), ("Y", resultType), ("IN", columns), ("OUT", rows),
                           ("RB", columns / format.block * format.bytes)],
                grid: (((rows + 31) / 32) * 128, (n + 7) / 8, 1), threadGroup: (128, 1, 1),
                outputShapes: [[n, rows]], outputDTypes: [resultType])[0]
        } else {
            projected = Self.gather(input, bytes: bytes, format: format, rows: rows, columns: columns,
                indices: ids, repeatInput: 1, outputType: resultType)
        }
        let output = projected.reshaped(Array(x.shape.dropLast()) + [rows])
        return outputOrder.map { take(output, $0, axis: -1) } ?? output
    }

    /// Gate/up projections have the same activation. Share only its Table16
    /// preparation, preserving each matrix's split policy and rounding. An
    /// input permutation or different precision needs its own preparation.
    package static func pair(_ x: MLXArray, _ first: Q2GGUFLinear,
                              _ second: Q2GGUFLinear) -> (MLXArray, MLXArray)? {
        guard first.columns == second.columns, x.dim(-1) == first.columns,
              first.inputOrder == nil, second.inputOrder == nil,
              first.inputType == second.inputType,
              let a = first.prepared, let b = second.prepared else { return nil }
        let input = first.inputType.map { x.asType($0) } ?? x
        let count = input.size / first.columns
        guard input.dtype == .bfloat16,
              NativeProjectionPolicy.useRegister(rows: a.rows, columns: a.columns, batch: count, format: a.format),
              NativeProjectionPolicy.useRegister(rows: b.rows, columns: b.columns, batch: count, format: b.format)
        else { return nil }
        let prepared = Q2RegisterProjection.Input(input, columns: first.columns)
        let parts = [a, b].map { weight in
            NativeProjectionPolicy.splits(rows: weight.rows, columns: weight.columns,
                cores: NativeProjectionPolicy.device.cores, register: true, apple10: true)
        }
        if let values = NativeProjectionSchedule.registerPair(prepared, first: a, second: b,
            splits: parts, types: [first.outputType ?? x.dtype, second.outputType ?? x.dtype]) {
            func finish(_ value: MLXArray, _ linear: Q2GGUFLinear) -> MLXArray {
                let output = value.reshaped(Array(x.shape.dropLast()) + [linear.rows])
                return linear.outputOrder.map { take(output, $0, axis: -1) } ?? output
            }
            return (finish(values[0], first), finish(values[1], second))
        }
        func project(_ linear: Q2GGUFLinear, _ weight: Q2ResidentWeights) -> MLXArray {
            let parts = NativeProjectionPolicy.splits(rows: weight.rows, columns: weight.columns,
                cores: NativeProjectionPolicy.device.cores, register: true, apple10: true)
            let output = Q2RegisterProjection.apply(prepared, weight: weight, splits: parts,
                outputType: linear.outputType ?? x.dtype).reshaped(Array(x.shape.dropLast()) + [weight.rows])
            return linear.outputOrder.map { take(output, $0, axis: -1) } ?? output
        }
        return (project(first, a), project(second, b))
    }

    /// Wide GDN QKV and gate projections preserve their staged arithmetic.
    /// Register projections retain their separate qualified path above.
    package static func stagedPair(_ x: MLXArray, _ first: Q2GGUFLinear,
                                   _ second: Q2GGUFLinear) -> (MLXArray, MLXArray)? {
        guard first.columns == second.columns, x.dim(-1) == first.columns,
              first.inputOrder == nil, second.inputOrder == nil,
              first.inputType == second.inputType,
              let a = first.prepared, let b = second.prepared else { return nil }
        let input = first.inputType.map { x.asType($0) } ?? x
        let count = input.size / first.columns
        guard (1...8).contains(count), input.dtype == .bfloat16,
              !NativeProjectionPolicy.useRegister(rows: a.rows, columns: a.columns, batch: count, format: a.format),
              !NativeProjectionPolicy.useRegister(rows: b.rows, columns: b.columns, batch: count, format: b.format) else { return nil }
        let parts = [a,b].map {
            NativeProjectionPolicy.splits(rows: $0.rows, columns: $0.columns,
                cores: NativeProjectionPolicy.device.cores, register: false,
                apple10: NativeProjectionPolicy.device.apple10)
        }
        guard let values = NativeProjectionSchedule.stagedPair(input, first: a, second: b,
            splits: parts, types: [first.outputType ?? x.dtype, second.outputType ?? x.dtype]) else { return nil }
        func finish(_ value: MLXArray, _ linear: Q2GGUFLinear) -> MLXArray {
            let output = value.reshaped(Array(x.shape.dropLast()) + [linear.rows])
            return linear.outputOrder.map { take(output, $0, axis: -1) } ?? output
        }
        return (finish(values[0],first),finish(values[1],second))
    }

    package static func gather(_ x: MLXArray, bytes: MLXArray, format: Q2GGUFFormat,
                       rows: Int, columns: Int, indices: MLXArray, repeatInput: Int, outputType: DType? = nil) -> MLXArray {
        precondition(columns.isMultiple(of: format.block) && repeatInput > 0)
        let n = indices.size
        return Kernels.shared.get(format).matvec([contiguous(x), contiguous(bytes), contiguous(indices)],
            template: [("T", x.dtype), ("Y", outputType ?? x.dtype), ("IN", columns), ("OUT", rows),
                       ("XREP", repeatInput), ("RB", columns / format.block * format.bytes)],
            grid: (32, rows, n), threadGroup: (32, 4, 1),
            outputShapes: [[n, rows]], outputDTypes: [outputType ?? x.dtype])[0]
    }

    package static func decode(_ bytes: MLXArray, format: Q2GGUFFormat, count: Int,
                       dtype: DType = .float32) -> MLXArray {
        Kernels.shared.get(format).decode([contiguous(bytes)],
            template: [("T", dtype), ("N", count)], grid: (count, 1, 1), threadGroup: (256, 1, 1),
            outputShapes: [[count]], outputDTypes: [dtype])[0]
    }

    private final class Kernels {
        static let shared = Kernels()
        let lock = NSLock()
        struct Pair { let matvec: MLXFast.MLXFastKernel; let decode: MLXFast.MLXFastKernel; let matmul: MLXFast.MLXFastKernel }
        var values: [Q2GGUFFormat: Pair] = [:]
        func get(_ format: Q2GGUFFormat) -> Pair {
            lock.withLock {
                if let pair = values[format] { return pair }
                let expression = "\(format.decoder)::decode(block, col % \(format.block))"
                let matvec = MLXFast.metalKernel(name: "slotstream_gguf_mv_\(format.rawValue)",
                    inputNames: ["x", "w", "ids"], outputNames: ["y"], source: """
                    uint lane = thread_position_in_grid.x;
                    uint row = thread_position_in_grid.y;
                    uint route = thread_position_in_grid.z;
                    if (row >= OUT) return;
                    const device uchar* base = w + (size_t(ids[route]) * OUT + row) * RB;
                    const device T* input = x + size_t(route / XREP) * IN;
                    float sum = 0;
                    for (uint col = lane; col < IN; col += 32) {
                        const device uchar* block = base + (col / \(format.block)) * \(format.bytes);
                        sum = fma(float(input[col]), \(expression), sum);
                    }
                    sum = simd_sum(sum);
                    if (lane == 0) y[size_t(route) * OUT + row] = Y(sum);
                    """, header: Q2GGUFKernelSources.header)
                let decode = MLXFast.metalKernel(name: "slotstream_gguf_decode_\(format.rawValue)",
                    inputNames: ["w"], outputNames: ["y"], source: """
                    uint col = thread_position_in_grid.x;
                    if (col >= N) return;
                    const device uchar* block = w + (col / \(format.block)) * \(format.bytes);
                    y[col] = T(\(expression));
                    """, header: Q2GGUFKernelSources.header)
                // Reuse a decoded weight tile across eight input rows. Like
                // Splash's staged GGUF path, staging is FP16 and accumulation
                // FP32; only the final output is rounded to the activation type.
                // Scratch is fixed per threadgroup, never a widened checkpoint.
                let matmul = MLXFast.metalKernel(name: "slotstream_gguf_mm_\(format.rawValue)",
                    inputNames: ["x", "w"], outputNames: ["y"], source: """
                    // The row count is runtime data. Specializing it compiled a
                    // fresh pipeline for every draft depth and contaminated the
                    // adaptive cost model with one-time compiler latency.
                    uint batchCount = x_shape[0];
                    uint tid = thread_index_in_threadgroup;
                    uint sg = simdgroup_index_in_threadgroup;
                    uint row0 = threadgroup_position_in_grid.x * 32;
                    uint batch0 = threadgroup_position_in_grid.y * 8;
                    threadgroup half xs[8 * 32];
                    threadgroup half ws[32 * 32];
                    threadgroup float result[4 * 64];
                    simdgroup_float8x8 acc = make_filled_simdgroup_matrix<float, 8, 8>(0.0f);
                    for (uint k0 = 0; k0 < IN; k0 += 32) {
                        for (uint i = tid; i < 256; i += 128) {
                            uint b = batch0 + i / 32, col = k0 + i % 32;
                            xs[i] = b < batchCount && col < IN ? half(x[size_t(b) * IN + col]) : half(0);
                        }
                        for (uint i = tid; i < 1024; i += 128) {
                            uint row = row0 + i / 32, col = k0 + i % 32;
                            half value = 0;
                            if (row < OUT && col < IN) {
                                const device uchar* block = w + size_t(row) * RB + (col / \(format.block)) * \(format.bytes);
                                value = half(\(expression));
                            }
                            ws[i] = value;
                        }
                        threadgroup_barrier(mem_flags::mem_threadgroup);
                        for (uint k = 0; k < 32; k += 8) {
                            simdgroup_half8x8 a, b;
                            simdgroup_load(a, xs + k, 32);
                            simdgroup_load(b, ws + sg * 8 * 32 + k, 32, ulong2(0), true);
                            simdgroup_multiply_accumulate(acc, a, b, acc);
                        }
                        threadgroup_barrier(mem_flags::mem_threadgroup);
                    }
                    simdgroup_store(acc, result + sg * 64, 8);
                    threadgroup_barrier(mem_flags::mem_threadgroup);
                    for (uint i = tid; i < 256; i += 128) {
                        uint b = i / 32, r = i % 32;
                        if (batch0 + b < batchCount && row0 + r < OUT)
                            y[size_t(batch0 + b) * OUT + row0 + r] = Y(result[(r / 8) * 64 + b * 8 + r % 8]);
                    }
                    """, header: "#include <metal_simdgroup_matrix>\n" + Q2GGUFKernelSources.header)
                let pair = Pair(matvec: matvec, decode: decode, matmul: matmul)
                values[format] = pair; return pair
            }
        }
    }
}
