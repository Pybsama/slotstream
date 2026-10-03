import Foundation
import MLX

/// Experimental fused expert projection for the reviewed VQ 3.2/4.4 runtime.
/// Not admitted by Engine.load. Cache ownership and whole-model qualification
/// must be established separately before a pack can use this path.
package struct VQExpert {
    private let codes: MLXArray
    private let prefillCodes: MLXArray
    private let codebook: MLXArray
    private let scales: MLXArray
    private let layout: VQLayout
    private let expertCount: Int
    private let outputRows: Int
    private let rowKernel: MLXFast.MLXFastKernel
    private let simdKernel: MLXFast.MLXFastKernel?
    private let prefillKernel: MLXFast.MLXFastKernel

    private static func kernel(source: String, name: String) throws -> MLXFast.MLXFastKernel {
        let original = "const device T* xrow = x + (size_t)t * IN;"
        guard source.components(separatedBy: original).count == 2 else {
            throw ModelError("VQ kernel input-row contract drifted")
        }
        let transformed = source.replacingOccurrences(of: original,
            with: "const device T* xrow = x + (size_t)(t / (uint)XKREP) * IN;")
        return MLXFast.metalKernel(name: "slotstream_vq_" + name,
            inputNames: ["x", "eidx", "codes", "codebook", "scales", "dims"], outputNames: ["y"], source: transformed)
    }

    // Geometry is deliberately limited to the inspected Flash Next expert
    // families. This is an implementation bound, not a quality/performance cap.
    package init(codes: MLXArray, codebook: MLXArray, scales: MLXArray, layout: VQLayout) throws {
        guard [640, 2560].contains(layout.columns), layout.groupSize == 64,
              codes.ndim == 3, (1...32).contains(codes.dim(0)), (1...2560).contains(codes.dim(1)),
              codebook.dtype == .float16, codebook.shape == [layout.codebookEntries, layout.dimensions],
              scales.dtype == .float16, scales.shape == [codes.dim(0), codes.dim(1), layout.columns / 64],
              codes.nbytes + codebook.nbytes + scales.nbytes <= 256_000_000 else {
            throw ModelError("VQ expert exceeds the bounded inspected projection geometry")
        }
        switch (layout.dimensions, layout.codebookEntries, layout.packing) {
        case (2, 256, .unpacked8):
            guard codes.dtype == .uint8, codes.dim(2) == layout.codeRowBytes else {
                throw ModelError("VQ U8 expert code shape or dtype mismatch")
            }
            self.codes = codes.view(dtype: .uint32)
        case (2, 1024, .words32), (4, 256, .words32), (4, 2048, .words32), (8, 16384, .words32):
            guard codes.dtype == .uint32, codes.dim(2) == layout.codeRowBytes / 4 else {
                throw ModelError("VQ packed expert code shape or dtype mismatch")
            }
            self.codes = codes.reshaped(codes.shape)
        default: throw ModelError("VQ expert layout is outside the inspected kernel families")
        }
        // MLXArray is a mutable reference object. Keep private array contexts
        // so caller-side assignment cannot retarget an admitted record. These
        // views retain values, not leases on externally reused bank memory.
        self.codebook = codebook.reshaped(codebook.shape)
        prefillCodes = codes.reshaped(codes.shape)
        self.scales = scales.reshaped(scales.shape); self.layout = layout
        expertCount = codes.dim(0); outputRows = codes.dim(1)
        let source: String
        switch layout.dimensions {
        case 2: source = layout.packing == .unpacked8 ? VQKernelSources.d2u8 : VQKernelSources.d2packed
        case 4: source = VQKernelSources.d4packed
        default: source = VQKernelSources.d8scalar
        }
        rowKernel = try Self.kernel(source: source, name: "d\(layout.dimensions)_" + layout.packing.rawValue)
        simdKernel = layout.dimensions == 8 ? try Self.kernel(source: VQKernelSources.d8simd, name: "d8simd") : nil
        let deviceBook = layout.codebookBytes >= 16_384 || layout.codebookBytes + 12_288 > 32_768
        // Match the pinned default specialization, including preprocessing
        // macros. Metal template arguments cannot drive this source's #if.
        var defines = [("BITS", layout.packing == .unpacked8 ? "0" : String(layout.bits)),
                       ("GROUP", "64"), ("MAX_K", deviceBook ? "1" : String(layout.codebookEntries)),
                       ("D_BAKE", String(layout.dimensions)), ("CB_DEV", deviceBook ? "1" : "0"),
                       ("RTILE", "32"), ("XPAD", "0"), ("TIO", "half"), ("OT2", "1"),
                       ("DSTORE", "0"), ("PIPE", "0"), ("PH2V", "1")]
        if layout.packing == .unpacked8 { defines.append(("CT", "uchar")) }
        let header = defines.map { "#define \($0.0) \($0.1)\n" }.joined()
        let name = "slotstream_vq_segmented_" + defines.map { $0.1 }.joined(separator: "_")
        prefillKernel = MLXFast.metalKernel(name: name,
            inputNames: ["codes", "codebook", "scales", "xsrc", "srcrows", "tmeta", "dims"], outputNames: ["y"],
            source: VQKernelSources.segmentedPrefill, header: header)
    }

    /// A complete expert segment retains all its routed rows when storage is
    /// partitioned. Each independent reference tile has at most 32 rows and
    /// 64 output columns. Keep the pinned F16 input/output conversion.
    package func prefill(_ x: MLXArray, expertIDs: [UInt32], sourceRows: [UInt32]) throws -> MLXArray {
        guard x.ndim == 2, x.dim(1) == layout.columns, (1...5120).contains(x.dim(0)),
              [.float16, .bfloat16].contains(x.dtype), (1...5120).contains(expertIDs.count),
              sourceRows.count == expertIDs.count, sourceRows.allSatisfy({ $0 < UInt32(x.dim(0)) }),
              expertIDs.allSatisfy({ $0 < UInt32(expertCount) }),
              zip(expertIDs, expertIDs.dropFirst()).allSatisfy({ $0 <= $1 }) else {
            throw ModelError("VQ segmented prefill requires bounded sorted experts and valid source rows")
        }
        var tiles: [Int32] = [], first = 0
        while first < expertIDs.count {
            var end = first + 1
            while end < expertIDs.count, expertIDs[end] == expertIDs[first] { end += 1 }
            guard end - first <= 512 else { throw ModelError("VQ prefill expert segment exceeds its bound") }
            for row in stride(from: first, to: end, by: 32) {
                tiles += [Int32(expertIDs[first]), Int32(row), Int32(min(32, end - row))]
            }
            first = end
        }
        let count = tiles.count / 3
        let dims = MLXArray([Int32(outputRows), Int32(layout.columns), Int32(layout.columns / 64),
                             Int32(layout.codebookEntries), Int32(count)])
        return prefillKernel([prefillCodes, codebook, scales, x.asType(.float16), MLXArray(sourceRows), MLXArray(tiles), dims],
            grid: (32 * ((outputRows + 63) / 64), 4 * count, 1), threadGroup: (32, 4, 1),
            outputShapes: [[expertIDs.count, outputRows]], outputDTypes: [.float16])[0].asType(x.dtype)
    }

    /// x is [tokenRows, inputColumns], indices is [tokenRows, topK]. The
    /// caller may flatten token/expert pairs for down_proj (then topK = 1).
    /// Inputs pass through F16 and results return to the original dtype, as
    /// VQ_DECODE_BF16IO=0 in the pinned reference. Packed D8 uses the reference
    /// SIMD reduction only at <=20 routed pairs and >=32 scale groups.
    package func call(_ x: MLXArray, indices: MLXArray) throws -> MLXArray {
        guard x.ndim == 2, indices.ndim == 2, indices.dtype == .uint32,
              indices.dim(0) == x.dim(0), (1...10).contains(indices.dim(1)),
              x.dim(0) > 0, x.dim(0) <= 4096 / indices.dim(1) else {
            throw ModelError("VQ expert route shape is outside the bounded projection")
        }
        return try operation(x, expertIDs: indices.asArray(UInt32.self), topK: indices.dim(1))()
    }

    /// Prepare a projection from CPU routing, which SSD-backed inference must
    /// already know before reading experts. Validate once and keep private
    /// array contexts in the closure; repeated calls need no GPU max/readback.
    /// This owns array values, not future cache-slot pins or allocator leases.
    package func operation(_ x: MLXArray, expertIDs: [UInt32], topK: Int,
                           dispatchPairs: Int? = nil) throws -> () -> MLXArray {
        guard x.ndim == 2, x.dim(1) == layout.columns, x.dim(0) > 0,
              [.float16, .bfloat16].contains(x.dtype), (1...10).contains(topK),
              x.dim(0) <= 4096 / topK, expertIDs.count == x.dim(0) * topK,
              expertIDs.allSatisfy({ $0 < UInt32(expertCount) }) else {
            throw ModelError("VQ expert inputs or expert indices are outside the bounded projection")
        }
        let input = x.reshaped(x.shape)
        let indices = MLXArray(expertIDs)
        let n = expertIDs.count
        // A storage partition must retain the original operation's arithmetic
        // dispatch. The kernel still sees its local rows for bounds and I/O.
        let wholePairs = dispatchPairs ?? n
        guard (n...4096).contains(wholePairs) else {
            throw ModelError("VQ partition dispatch must cover its rows within the fused reference bound")
        }
        let simd = layout.dimensions == 8 && wholePairs <= 20 && layout.columns / 64 >= 32
        let kernel = simd ? simdKernel! : rowKernel
        let dims = MLXArray([Int32(outputRows), Int32(layout.columns), Int32(layout.dimensions), Int32(64), Int32(n), Int32(layout.codebookEntries)])
        let group = min(256, outputRows)
        return { kernel([input.asType(.float16), indices, codes, codebook, scales, dims],
            template: [("T", DType.float16), ("BITS", layout.bits), ("MAX_K", layout.codebookEntries),
                ("MAX_NSUB", layout.columns / layout.dimensions), ("MAX_NX4", layout.columns / 4),
                ("MAX_TILE", 512), ("SZ", 0), ("XKREP", topK)],
            grid: simd ? (32, ((outputRows + 7) / 8) * 8, n) : (((outputRows + group - 1) / group) * group, n, 1),
            threadGroup: simd ? (32, 8, 1) : (group, 1, 1),
            outputShapes: [[input.dim(0), topK, outputRows]], outputDTypes: [.float16])[0].asType(input.dtype) }
    }
}
