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
    package let pieceBytes: [Int]
    package init(_ pieces: [Piece]) throws {
        guard pieces.count == 6 else { throw ModelError("VQ read plan requires all six pieces") }
        for piece in pieces {
            guard let ref = piece.file.tensors[piece.name], ref.shape.first == 512,
                  ref.rowBytes == piece.bytes, piece.bytes > 0,
                  ref.byteCount == (try QuantizationBytes.product(512, piece.bytes)) else {
                throw ModelError("VQ immutable read plan disagrees with its authenticated extent")
            }
        }
        self.pieces = pieces; pieceBytes = pieces.map(\.bytes)
        _ = try VQRecordReadBatch.reservation(jobs: 32, pieceBytes: pieceBytes)
    }
    package func read(expert: Int, shouldContinue: @escaping @Sendable () -> Bool) throws -> [Data] {
        guard (0..<512).contains(expert) else { throw ModelError("VQ read plan expert is out of range") }
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
