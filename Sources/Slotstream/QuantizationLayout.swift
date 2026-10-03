import Foundation

/// Validated storage geometry, separate from model support and qualification.
/// Constructing a descriptor does not enable the format in Engine.load.
public struct AffineQuantization: Hashable, Sendable {
    public let bits: Int
    public let groupSize: Int

    public init(bits: Int, groupSize: Int) throws {
        guard [2, 3, 4, 5, 6, 8].contains(bits), [32, 64, 128].contains(groupSize) else {
            throw ModelError("unsupported affine quantization bits or group size")
        }
        self.bits = bits; self.groupSize = groupSize
    }

    /// MLX packs complete groups into UInt32 words. Fractional words are never
    /// rounded down (3-bit rows are not `columns / (32 / bits)`).
    public func packedWords(columns: Int) throws -> Int {
        guard columns > 0, columns.isMultiple(of: groupSize) else {
            throw ModelError("affine columns must contain complete scale groups")
        }
        let value = try QuantizationBytes.product(columns, bits)
        guard value.isMultiple(of: 32) else { throw ModelError("affine row is not word aligned") }
        return value / 32
    }

    public func rowBytes(columns: Int, scaleBytes: Int = 2, hasBias: Bool = true) throws -> Int {
        guard [2, 4].contains(scaleBytes) else { throw ModelError("unsupported affine scale dtype") }
        return try QuantizationBytes.sum(QuantizationBytes.product(packedWords(columns: columns), 4),
            QuantizationBytes.product(columns / groupSize, scaleBytes, hasBias ? 2 : 1))
    }
}

/// The two upstream VQ packing schemes are different: expert codes use padded
/// UInt32 rows; PLE uses byte-packed rows with no 32-code padding. Unpacked U8
/// or U16 is a third representation. Never infer one from an advertised bpw.
public struct VQLayout: Hashable, Sendable {
    public enum Packing: String, Sendable { case unpacked8, unpacked16, words32, bytes }
    public let columns: Int
    public let dimensions: Int
    public let codebookEntries: Int
    public let groupSize: Int
    public let packing: Packing
    public let bits: Int
    public let codeRowBytes: Int
    public let scaleRowBytes: Int
    public let codebookBytes: Int

    public init(columns: Int, dimensions: Int, codebookEntries: Int, groupSize: Int, packing: Packing) throws {
        guard columns > 0, columns <= 8192, [2, 4, 8].contains(dimensions),
              [32, 64, 128].contains(groupSize), columns.isMultiple(of: dimensions),
              columns.isMultiple(of: groupSize), groupSize.isMultiple(of: dimensions),
              codebookEntries >= 2, codebookEntries <= 65536,
              codebookEntries.nonzeroBitCount == 1 else {
            throw ModelError("unsupported VQ dimensions, groups or codebook")
        }
        let bits = codebookEntries.trailingZeroBitCount
        let codes = columns / dimensions
        let bytes: Int
        switch packing {
        case .unpacked8:
            guard bits <= 8 else { throw ModelError("VQ codebook cannot be addressed by U8") }
            bytes = codes
        case .unpacked16: bytes = try QuantizationBytes.product(codes, 2)
        case .words32:
            bytes = try QuantizationBytes.product((codes + 31) / 32, bits, 4)
        case .bytes:
            let bitCount = try QuantizationBytes.product(codes, bits)
            guard bitCount.isMultiple(of: 8) else { throw ModelError("byte-packed VQ rows must be byte aligned") }
            bytes = bitCount / 8
        }
        self.columns = columns; self.dimensions = dimensions; self.codebookEntries = codebookEntries
        self.groupSize = groupSize; self.packing = packing; self.bits = bits; self.codeRowBytes = bytes
        self.scaleRowBytes = try QuantizationBytes.product(columns / groupSize, 2)
        self.codebookBytes = try QuantizationBytes.product(codebookEntries, dimensions, 2)
    }

    public func recordBytes(rows: Int) throws -> Int {
        guard rows > 0 else { throw ModelError("VQ record requires output rows") }
        return try QuantizationBytes.product(rows, QuantizationBytes.sum(codeRowBytes, scaleRowBytes))
    }
}

/// Reject overflow instead of turning invalid metadata into a smaller budget.
package enum QuantizationBytes {
    package static func product(_ values: Int...) throws -> Int {
        var result = 1
        for value in values {
            guard value >= 0 else { throw ModelError("negative quantization extent") }
            let next = result.multipliedReportingOverflow(by: value)
            guard !next.overflow else { throw ModelError("quantization byte size overflow") }
            result = next.partialValue
        }
        return result
    }
    package static func sum(_ values: Int...) throws -> Int {
        var result = 0
        for value in values {
            guard value >= 0 else { throw ModelError("negative quantization extent") }
            let next = result.addingReportingOverflow(value)
            guard !next.overflow else { throw ModelError("quantization byte size overflow") }
            result = next.partialValue
        }
        return result
    }
}
