import CryptoKit
import Darwin
import Foundation

/// Lossless derived expert storage for one frozen research artifact. Admission
/// binds the manifest and every complete payload, not a user-provided checksum.
/// Original codebooks, prefill sweep storage and model values remain unchanged.
package final class VQPackedExperts {
    package static let manifestSHA256 = "230c53d8bea76e245c8c47863db3fc0f93c549865e7393b5a493c07b0f52b834"
    package static let totalFileBytes = 47_866_183_680
    private struct Piece: Decodable { let name: String, shard: String; let bytes: Int, offset: Int }
    private struct Layer: Decodable {
        let layer: Int, filename: String, record_bytes: Int, stride_bytes: Int, file_bytes: Int
        let pieces: [Piece], source_tensor_sha256: [String], sha256: String
    }
    private struct Manifest: Decodable {
        let schema: Int, layout: String, parent_inventory_sha256: String
        let layers: [Layer]
    }
    private let directory: URL
    private let layers: [Layer]
    private var files: [Int: VQTensorFile] = [:]
    package var verifiedFileCount: Int { files.count }
    package var verifiedFileBytes: Int { files.keys.reduce(0) { $0 + layers[$1].file_bytes } }

    private static func hash(_ data: Data) -> String {
        SHA256.hash(data: data).map { String(format: "%02x", $0) }.joined()
    }

    package init(directory: URL, inventorySHA256: String, layouts: [VQRecordLayout]) throws {
        let url = directory.appendingPathComponent("manifest.json")
        let fd = open(url.path, O_RDONLY | O_NOFOLLOW | O_NONBLOCK | O_CLOEXEC)
        guard fd >= 0 else { throw ModelError("cannot open pinned VQ packed manifest") }
        defer { close(fd) }
        let initial = try PackedExpertLayout.Stamp(fd: fd)
        guard (1...1_000_000).contains(initial.size) else { throw ModelError("VQ packed manifest exceeds its bound") }
        var raw = Data(count: Int(initial.size))
        try raw.withUnsafeMutableBytes { try PackedExpertLayout.read(fd, into: $0.baseAddress!, offset: 0, count: $0.count) }
        guard try PackedExpertLayout.Stamp(fd: fd) == initial, Self.hash(raw) == Self.manifestSHA256 else {
            throw ModelError("VQ packed manifest differs from the verified derivation")
        }
        let manifest = try JSONDecoder().decode(Manifest.self, from: raw)
        guard manifest.schema == 1, manifest.layout == "slotstream-vq-layer-expert-six-piece-16k-v1",
              manifest.parent_inventory_sha256 == VQDenseOverlay.parentInventorySHA256,
              inventorySHA256 == manifest.parent_inventory_sha256,
              layouts.count == 48, manifest.layers.count == 48 else {
            throw ModelError("VQ packed storage belongs to another parent or layout")
        }
        var total = 0
        for (index, layer) in manifest.layers.enumerated() {
            let layout = layouts[index]
            let stride = try QuantizationBytes.product((try QuantizationBytes.sum(layout.recordBytes, 16383)) / 16384, 16384)
            guard layer.layer == index, layer.filename == String(format: "experts-%02d.safetensors", index),
                  layer.record_bytes == layout.recordBytes, layer.stride_bytes == stride,
                  [1_851_392, 2_621_440].contains(stride), layer.pieces.count == 6,
                  layer.file_bytes == (try QuantizationBytes.sum(16384, QuantizationBytes.product(512, stride))),
                  layer.source_tensor_sha256.count == 6 else {
                throw ModelError("VQ packed extent differs from the inspected complete-record ledger")
            }
            var offset = 0
            for (piece, value) in layer.pieces.enumerated() {
                let family = ["gate_proj", "up_proj", "down_proj"][piece / 2]
                let suffix = piece % 2 == 0 ? "codes" : "vq_scales"
                guard value.name == "model.layers.\(index).mlp.switch_mlp.\(family).\(suffix)",
                      value.bytes == layout.pieceBytes[piece], value.offset == offset else {
                    throw ModelError("VQ packed tensor order or piece extent changed")
                }
                offset = try QuantizationBytes.sum(offset, value.bytes)
            }
            total = try QuantizationBytes.sum(total, layer.file_bytes)
        }
        guard total == Self.totalFileBytes else { throw ModelError("VQ packed file ledger changed") }
        self.directory = directory; layers = manifest.layers
    }

    private func file(_ layer: Int, shouldContinue: () -> Bool) throws -> VQTensorFile {
        guard layers.indices.contains(layer) else { throw ModelError("VQ packed layer is out of range") }
        if let owned = files[layer] { try owned.verifyUnchanged(); return owned }
        let item = layers[layer], payload = item.file_bytes - 16384
        // Canonical sorted JSON plus space padding, exactly the export header.
        var header = Data("{\"records\":{\"data_offsets\":[0,\(payload)],\"dtype\":\"U8\",\"shape\":[512,\(item.stride_bytes)]}}".utf8)
        guard header.count <= 16376 else { throw ModelError("VQ packed header exceeds its alignment") }
        header.append(Data(repeating: 32, count: 16376 - header.count))
        let owned = try VQTensorFile(url: directory.appendingPathComponent(item.filename),
            identity: .init(fileBytes: item.file_bytes, headerBytes: 16376,
                            headerSHA256: Self.hash(header), fileSHA256: item.sha256),
            shouldContinue: shouldContinue)
        guard owned.tensors.count == 1, let records = owned.tensors["records"], records.dtype == "U8",
              records.shape == [512, item.stride_bytes], records.byteOffset == 16384 else {
            throw ModelError("authenticated VQ packed payload has unexpected geometry")
        }
        files[layer] = owned; return owned
    }

    package func authenticateAll(shouldContinue: () -> Bool) throws {
        for layer in layers.indices {
            guard shouldContinue(), let vm = ProcessMemory.vmActivity(), vm.reclaimableBytes >= 3_000_000_000,
                  ProcessMemory.peakResidentBytes() <= 10_000_000_000 else {
                throw ModelError("VQ packed authentication lost its resource envelope")
            }
            _ = try file(layer, shouldContinue: shouldContinue)
        }
    }

    package func readPlan(layer: Int) throws -> VQRecordReadPlan {
        let owned = try file(layer, shouldContinue: { true })
        return try VQRecordReadPlan(packed: owned, pieceBytes: layers[layer].pieces.map(\.bytes))
    }
}
