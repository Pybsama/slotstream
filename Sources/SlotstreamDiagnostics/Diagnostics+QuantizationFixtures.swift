import CryptoKit
import Foundation
import MLX
import Slotstream

extension Diagnostics {
    /// Exact native decoding against separately extracted scalar CPU oracles.
    /// Bound both file reads and GPU output before the MLX loader sees a file.
    public static func quantizationFixtures(directory: URL, fused: Bool = false) throws -> CheckReport {
        struct Fixture: Decodable {
            let path: String
            let sha256: String
            let bytes: Int
            let columns: Int
            let dimensions: Int
            let entries: Int
            let group_size: Int
            let packing: String
        }
        struct Manifest: Decodable {
            let schema: Int
            let repo: String?
            let revision: String?
            let runtime_sha256: String?
            let fixtures: [Fixture]
        }
        func boundedData(_ file: URL, limit: Int) throws -> Data {
            let handle = try FileHandle(forReadingFrom: file)
            defer { try? handle.close() }
            let size = try handle.seekToEnd()
            guard size > 0, size <= limit else { throw ModelError("VQ fixture exceeds its bounded read") }
            try handle.seek(toOffset: 0)
            guard let data = try handle.read(upToCount: limit + 1), data.count == Int(size) else {
                throw ModelError("VQ fixture changed or truncated during read")
            }
            return data
        }
        let manifest = try JSONDecoder().decode(Manifest.self,
            from: boundedData(directory.appendingPathComponent(fused ? "fused.json" : "fixtures.json"), limit: 1_000_000))
        guard manifest.schema == 1, (1...(fused ? 128 : 32)).contains(manifest.fixtures.count),
              Set(manifest.fixtures.map(\.path)).count == manifest.fixtures.count else {
            throw ModelError("unsupported or unpinned VQ fixture manifest")
        }
        if fused {
            guard manifest.runtime_sha256 == "1685ec90feb24e421c379ae4e3594f659478905d2c1393617990d84d3f514ee8" else {
                throw ModelError("unsupported VQ fused reference runtime")
            }
        } else if manifest.revision?.range(of: "^[0-9a-f]{40}$", options: .regularExpression) == nil {
            throw ModelError("unpinned VQ row fixture manifest")
        }
        try ModelProcessGuard.acquire()
        var c = CheckBuilder(fused ? "quantization-fused-fixtures" : "quantization-fixtures")
        return try withError {
            for fixture in manifest.fixtures {
                let pattern = fused ? "^fused-[0-9]+\\.safetensors$" : "^fixture-[0-9]+\\.safetensors$"
                guard fixture.path.range(of: pattern, options: .regularExpression) != nil,
                      fixture.bytes > 0, fixture.bytes <= 8_000_000,
                      let packing = VQLayout.Packing(rawValue: fixture.packing) else {
                    throw ModelError("unsupported fixture path or extent")
                }
                let layout = try VQLayout(columns: fixture.columns, dimensions: fixture.dimensions,
                    codebookEntries: fixture.entries, groupSize: fixture.group_size, packing: packing)
                let path = directory.appendingPathComponent(fixture.path)
                let data = try boundedData(path, limit: 8_000_000)
                let digest = SHA256.hash(data: data).map { String(format: "%02x", $0) }.joined()
                guard data.count == fixture.bytes, digest == fixture.sha256 else { throw ModelError("VQ fixture digest mismatch") }
                // Load the verified bytes, not a second read of the source path.
                // The temporary file is private to this checker and removed on
                // every exit; a concurrent replacement cannot change the input.
                let scratch = FileManager.default.temporaryDirectory.appendingPathComponent("slotstream-vq-\(UUID().uuidString)", isDirectory: true)
                try FileManager.default.createDirectory(at: scratch, withIntermediateDirectories: false,
                    attributes: [.posixPermissions: 0o700])
                defer { try? FileManager.default.removeItem(at: scratch) }
                let verified = scratch.appendingPathComponent("fixture.safetensors")
                try data.write(to: verified, options: .atomic)
                let arrays = try loadArrays(url: verified)
                if fused {
                    guard Set(arrays.keys) == Set(["x", "indices", "codes", "codebook", "vq_scales", "expected"]),
                          let x = arrays["x"], let indices = arrays["indices"], let codes = arrays["codes"],
                          let book = arrays["codebook"], let scales = arrays["vq_scales"], let expected = arrays["expected"],
                          expected.dtype == .bfloat16, expected.ndim == 3, expected.dim(2) == 7 else {
                        throw ModelError("VQ fused fixture has unexpected tensors")
                    }
                    let projection = try VQExpert(codes: codes, codebook: book, scales: scales, layout: layout)
                    let actual = try projection.call(x, indices: indices)
                    guard actual.shape == expected.shape else { throw ModelError("VQ fused output shape mismatch") }
                    c.equal("\(fixture.path) exact Python/native fused binding bits",
                        actual.reshaped([-1]).view(dtype: .uint16).asArray(UInt16.self),
                        expected.reshaped([-1]).view(dtype: .uint16).asArray(UInt16.self))
                    continue
                }
                guard Set(arrays.keys) == Set(["codes", "codebook", "vq_scales", "expected"]),
                      let codes = arrays["codes"], let book = arrays["codebook"], let scales = arrays["vq_scales"],
                      let expected = arrays["expected"], expected.dtype == .float16,
                      expected.shape == [7, layout.columns], codes.ndim == 2, codes.dim(0) == 7 else {
                    throw ModelError("VQ fixture has unexpected tensors")
                }
                let actual = try VQDecode.rows(codes: codes, codebook: book, scales: scales, layout: layout)
                c.equal("\(fixture.path) exact native decoded row bits",
                    actual.reshaped([-1]).view(dtype: .uint16).asArray(UInt16.self),
                    expected.reshaped([-1]).view(dtype: .uint16).asArray(UInt16.self))
            }
            return c.report()
        }
    }
}
