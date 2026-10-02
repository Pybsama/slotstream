import CryptoKit
import Foundation
import MLX
import Slotstream

extension Diagnostics {
    /// Exact native decoding against separately extracted scalar CPU oracles.
    /// Bound both file reads and GPU output before the MLX loader sees a file.
    public static func quantizationFixtures(directory: URL) throws -> CheckReport {
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
            let repo: String
            let revision: String
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
            from: boundedData(directory.appendingPathComponent("fixtures.json"), limit: 1_000_000))
        guard manifest.schema == 1, (1...32).contains(manifest.fixtures.count),
              manifest.revision.range(of: "^[0-9a-f]{40}$", options: .regularExpression) != nil,
              Set(manifest.fixtures.map(\.path)).count == manifest.fixtures.count else {
            throw ModelError("unsupported or unpinned VQ fixture manifest")
        }
        try ModelProcessGuard.acquire()
        var c = CheckBuilder("quantization-fixtures")
        return try withError {
            for fixture in manifest.fixtures {
                guard fixture.path.range(of: "^fixture-[0-9]+\\.safetensors$", options: .regularExpression) != nil,
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
