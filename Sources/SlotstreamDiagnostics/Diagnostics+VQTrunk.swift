import CryptoKit
import Foundation
import MLX
import Slotstream

extension Diagnostics {
    public static func quantizationTrunk(directory: URL) throws -> CheckReport {
        struct File: Decodable { let path: String, bytes: Int, sha256: String }
        struct Manifest: Decodable {
            let schema: Int, architecture_sha256: String, normalization: String
            let token_rows: [Int], fixture: File
        }
        func read(_ url: URL, bound: Int) throws -> Data {
            let handle = try FileHandle(forReadingFrom: url)
            defer { try? handle.close() }
            guard let data = try handle.read(upToCount: bound + 1), !data.isEmpty, data.count <= bound else {
                throw ModelError("VQ trunk fixture exceeds its read bound")
            }
            return data
        }
        let manifest = try JSONDecoder().decode(Manifest.self,
            from: read(directory.appendingPathComponent("trunk.json"), bound: 1_000_000))
        guard manifest.schema == 1, manifest.token_rows == [1, 3, 17],
              manifest.architecture_sha256 == "d6470a2131a64ff37024dfffd2b5bc8c3f4db625f0f3b1ceec7fe346852c1a87",
              manifest.normalization == "vq-raw-zero-centered-to-pr1788-folded-bf16-v1",
              manifest.fixture.path == "trunk.safetensors", (1...160_000_000).contains(manifest.fixture.bytes) else {
            throw ModelError("VQ trunk fixture must bind the corrected pinned arithmetic profile")
        }
        try ModelProcessGuard.acquire()
        guard let vm = ProcessMemory.vmActivity(), vm.reclaimableBytes >= 5_000_000_000 else {
            throw ModelError("VQ trunk check needs 5 GB actual reclaimable memory")
        }
        let oldCache = MLX.Memory.cacheLimit, oldLimit = MLX.Memory.memoryLimit
        MLX.Memory.cacheLimit = 64_000_000; MLX.Memory.memoryLimit = min(oldLimit, 1_000_000_000)
        defer {
            Stream.gpu.synchronize(); MLX.Memory.clearCache()
            MLX.Memory.cacheLimit = oldCache; MLX.Memory.memoryLimit = oldLimit
        }
        let data = try read(directory.appendingPathComponent(manifest.fixture.path), bound: 160_000_000)
        let hash = SHA256.hash(data: data).map { String(format: "%02x", $0) }.joined()
        guard data.count == manifest.fixture.bytes, hash == manifest.fixture.sha256 else {
            throw ModelError("VQ trunk fixture digest mismatch")
        }
        let scratch = FileManager.default.temporaryDirectory.appendingPathComponent("slotstream-vq-trunk-" + UUID().uuidString)
        try FileManager.default.createDirectory(at: scratch, withIntermediateDirectories: false, attributes: [.posixPermissions: 0o700])
        defer { try? FileManager.default.removeItem(at: scratch) }
        let path = scratch.appendingPathComponent("verified.safetensors")
        try data.write(to: path, options: .atomic)
        var c = CheckBuilder("quantization-trunk")
        return try withError {
            let arrays = try loadArrays(url: path)
            let weights = arrays.filter { $0.key.hasPrefix("model.layers.0.") }
            let outputs = ["mixed", "inject", "output", "conv", "state", "continued", "continued_conv", "continued_state"]
            let cases = Set(manifest.token_rows.flatMap { count in (["hyper"] + outputs).map { $0 + String(count) } })
            guard Set(arrays.keys) == Set(weights.keys).union(cases) else { throw ModelError("VQ trunk fixture tensor set mismatch") }
            for count in manifest.token_rows {
                let actual = try VQTrunkProbe.run(weights: weights, hyper: arrays["hyper\(count)"]!)
                for name in outputs {
                    let got = actual[name]!, want = arrays[name + String(count)]!
                    c.expect("T\(count) \(name) finite", all(isFinite(got)).item(Bool.self))
                    c.expect("T\(count) \(name) shape and dtype", got.shape == want.shape && got.dtype == want.dtype)
                    c.expect("T\(count) \(name) exact bits", got.asData(access: .copy).data == want.asData(access: .copy).data)
                }
                c.expect("T\(count) readout preserves reference output", actual["forecast"]!.asData(access: .copy).data
                         == arrays["output\(count)"]!.asData(access: .copy).data)
            }
            guard ProcessMemory.peakResidentBytes() <= 2_000_000_000 else { throw ModelError("VQ trunk check exceeded its 2 GB component bound") }
            return c.report()
        }
    }
}
