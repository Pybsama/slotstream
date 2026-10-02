import MLX

/// Bounded native decoder used by candidate screening. This is not a full VQ
/// model path: engine admission continues to require the qualified affine pack.
/// Decode in independent row batches; never expand all experts or the PLE table.
package enum VQDecode {
    private static let kernel = MLXFast.metalKernel(
        name: "slotstream_vq_decode_rows", inputNames: ["codes", "book", "scales"], outputNames: ["decoded"],
        source: """
        uint i = thread_position_in_grid.x;
        if (i >= Rows * Columns) return;
        uint row = i / Columns, column = i % Columns;
        uint sub = column / Dimensions;
        uint code;
        if (Packing == 0 || Packing == 1) {
            code = uint(codes[row * CodeStride + sub]);
        } else if (Packing == 2) {
            uint bit = sub * Bits, word = bit / 32, shift = bit % 32;
            code = uint(codes[row * CodeStride + word]) >> shift;
            if (shift + Bits > 32) code |= uint(codes[row * CodeStride + word + 1]) << (32 - shift);
            code &= (1u << Bits) - 1u;
        } else {
            uint bit = sub * Bits, byte = bit / 8, shift = bit % 8;
            code = uint(codes[row * CodeStride + byte]);
            if (byte + 1 < CodeStride) code |= uint(codes[row * CodeStride + byte + 1]) << 8;
            if (byte + 2 < CodeStride) code |= uint(codes[row * CodeStride + byte + 2]) << 16;
            code = (code >> shift) & ((1u << Bits) - 1u);
        }
        // Unpacked codes can address a smaller codebook. Never read outside it.
        // The host validates these codes before dispatch; this guard is defense
        // in depth and is not a substitute for refusing a corrupt artifact.
        if (code >= Entries) { decoded[i] = half(NAN); return; }
        float weight = float(book[code * Dimensions + column % Dimensions]);
        float scale = float(scales[row * (Columns / Group) + column / Group]);
        decoded[i] = half(weight * scale);
        """)

    package static func rows(codes: MLXArray, codebook: MLXArray, scales: MLXArray, layout: VQLayout) throws -> MLXArray {
        let dtype: DType, packing: Int
        switch layout.packing {
        case .unpacked8: dtype = .uint8; packing = 0
        case .unpacked16: dtype = .uint16; packing = 1
        case .words32: dtype = .uint32; packing = 2
        case .bytes: dtype = .uint8; packing = 3
        }
        guard codes.ndim == 2, codes.dim(0) > 0, codes.dtype == dtype,
              codes.dim(1) == layout.codeRowBytes / dtype.size,
              codebook.dtype == .float16, codebook.shape == [layout.codebookEntries, layout.dimensions],
              scales.dtype == .float16, scales.shape == [codes.dim(0), layout.columns / layout.groupSize],
              codes.dim(0) <= 16_777_216 / layout.columns else {
            throw ModelError("VQ decode input does not fit its validated bounded layout")
        }
        if packing < 2 {
            let largest = max(codes).item(UInt32.self)
            guard largest < UInt32(layout.codebookEntries) else { throw ModelError("VQ code is outside its codebook") }
        }
        return kernel([codes, codebook, scales], template: [
            ("Rows", codes.dim(0)), ("Columns", layout.columns), ("Dimensions", layout.dimensions),
            ("Entries", layout.codebookEntries), ("Group", layout.groupSize), ("Bits", layout.bits),
            ("Packing", packing), ("CodeStride", codes.dim(1))],
            grid: (codes.dim(0) * layout.columns, 1, 1), threadGroup: (256, 1, 1),
            outputShapes: [[codes.dim(0), layout.columns]], outputDTypes: [.float16])[0]
    }
}
