import Foundation
import MLX

/// Code objects only: no weights, array contexts, cache leases or outputs.
/// The five admitted source/header specializations are the entire key space.
/// Invocation still supplies fresh arrays, shape metadata and template values.
package struct VQExpertKernels {
    package let row: MLXFast.MLXFastKernel
    package let simd: MLXFast.MLXFastKernel?
    package let prefill: MLXFast.MLXFastKernel

    private enum Family: Hashable {
        case d2u8, d2k1024, d4k256, d4k2048, d8k16384
        init(_ layout: VQLayout) throws {
            guard [640, 2560].contains(layout.columns), layout.groupSize == 64 else {
                throw ModelError("VQ kernel cache requires an admitted expert geometry")
            }
            switch (layout.dimensions, layout.codebookEntries, layout.packing) {
            case (2, 256, .unpacked8): self = .d2u8
            case (2, 1024, .words32): self = .d2k1024
            case (4, 256, .words32): self = .d4k256
            case (4, 2048, .words32): self = .d4k2048
            case (8, 16384, .words32): self = .d8k16384
            default: throw ModelError("VQ kernel cache has no admitted specialization")
            }
        }
    }
    private final class Cache: @unchecked Sendable {
        let lock = NSLock()
        var values: [Family: VQExpertKernels] = [:]
        func get(_ layout: VQLayout) throws -> VQExpertKernels {
            let family = try Family(layout)
            return try lock.withLock {
                if let value = values[family] { return value }
                let value = try VQExpertKernels(layout)
                values[family] = value
                return value
            }
        }
    }
    private static let cache = Cache()
    package static func shared(_ layout: VQLayout) throws -> VQExpertKernels {
        try cache.get(layout)
    }

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

    private init(_ layout: VQLayout) throws {
        let source: String
        switch layout.dimensions {
        case 2: source = layout.packing == .unpacked8 ? VQKernelSources.d2u8 : VQKernelSources.d2packed
        case 4: source = VQKernelSources.d4packed
        default: source = VQKernelSources.d8scalar
        }
        row = try Self.kernel(source: source, name: "d\(layout.dimensions)_" + layout.packing.rawValue)
        simd = layout.dimensions == 8 ? try Self.kernel(source: VQKernelSources.d8simd, name: "d8simd") : nil
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
        prefill = MLXFast.metalKernel(name: name,
            inputNames: ["codes", "codebook", "scales", "xsrc", "srcrows", "tmeta", "dims"], outputNames: ["y"],
            source: VQKernelSources.segmentedPrefill, header: header)
    }
}
