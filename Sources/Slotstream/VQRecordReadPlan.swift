import Foundation

/// Immutable descriptor/range plan prepared by the checkpoint owner. Its only
/// cross-thread references are immutable VQTensorFile owners: their descriptor,
/// original stamp and tensor map never change after construction, and reads use
/// pread plus local Data. The strong owners outlive every joined worker.
package final class VQRecordReadPlan: @unchecked Sendable {
    package struct Piece {
        package let file: VQTensorFile
        package let name: String
        package let bytes: Int
        package init(file: VQTensorFile, name: String, bytes: Int) {
            self.file = file; self.name = name; self.bytes = bytes
        }
    }
    private let pieces: [Piece]
    private let packed: VQTensorFile?
    package let pieceBytes: [Int]
    package let scratchReadBytes: Int
    package init(_ pieces: [Piece]) throws {
        guard pieces.count == 6 else { throw ModelError("VQ read plan requires all six pieces") }
        for piece in pieces {
            guard let ref = piece.file.tensors[piece.name], ref.shape.first == 512,
                  ref.rowBytes == piece.bytes, piece.bytes > 0,
                  ref.byteCount == (try QuantizationBytes.product(512, piece.bytes)) else {
                throw ModelError("VQ immutable read plan disagrees with its authenticated extent")
            }
        }
        self.pieces = pieces; packed = nil; pieceBytes = pieces.map(\.bytes)
        scratchReadBytes = VQTensorFile.maximumRead
        _ = try VQRecordReadBatch.reservation(jobs: 32, pieceBytes: pieceBytes)
    }

    package init(packed: VQTensorFile, pieceBytes: [Int]) throws {
        guard packed.tensors.count == 1, let ref = packed.tensors["records"],
              ref.dtype == "U8", ref.shape.count == 2, ref.shape[0] == 512,
              [1_851_392, 2_621_440].contains(ref.rowBytes), ref.shape[1] == ref.rowBytes,
              pieceBytes.count == 6, pieceBytes.allSatisfy({ (1...1_500_000).contains($0) }) else {
            throw ModelError("VQ packed read plan differs from the authenticated record extent")
        }
        let bytes = try pieceBytes.reduce(0) { try QuantizationBytes.sum($0, $1) }
        guard ((try QuantizationBytes.sum(bytes, 16383)) / 16384) * 16384 == ref.rowBytes else {
            throw ModelError("VQ packed pieces do not fit their aligned record")
        }
        self.packed = packed; pieces = []; self.pieceBytes = pieceBytes; scratchReadBytes = ref.rowBytes
        _ = try VQRecordReadBatch.reservation(jobs: 32, pieceBytes: pieceBytes, scratchReadBytes: scratchReadBytes)
    }

    package func read(expert: Int, shouldContinue: @escaping @Sendable () -> Bool) throws -> [Data] {
        guard (0..<512).contains(expert) else { throw ModelError("VQ read plan expert is out of range") }
        if let packed {
            let record = try packed.readPackedRecord(expert: expert, shouldContinue: shouldContinue)
            var offset = 0, result: [Data] = []
            for count in pieceBytes {
                guard shouldContinue() else { throw CheckpointReadError.cancelled }
                result.append(record.subdata(in: offset..<(offset + count))); offset += count
            }
            guard shouldContinue() else { throw CheckpointReadError.cancelled }
            return result
        }
        var output: [Data] = []
        for piece in pieces {
            guard shouldContinue() else { throw CheckpointReadError.cancelled }
            var data = Data(); data.reserveCapacity(piece.bytes)
            var offset = 0
            while offset < piece.bytes {
                let count = min(VQTensorFile.maximumRead, piece.bytes - offset)
                data.append(try piece.file.read(piece.name, offset: expert * piece.bytes + offset,
                                               count: count, shouldContinue: shouldContinue))
                offset += count
            }
            output.append(data)
        }
        guard shouldContinue() else { throw CheckpointReadError.cancelled }
        return output
    }
}
