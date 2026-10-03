import CryptoKit
import Foundation
import MLX
import Slotstream

extension Diagnostics {
    /// Exact native decoding against separately extracted scalar CPU oracles.
    /// Bound both file reads and GPU output before the MLX loader sees a file.
    public static func quantizationFixtures(directory: URL, fused: Bool = false,
                                            sourceDirectory: URL? = nil, inventory: URL? = nil) throws -> CheckReport {
        struct Fixture: Decodable {
            let path: String
            let sha256: String
            let bytes: Int
            let columns: Int
            let dimensions: Int
            let entries: Int
            let group_size: Int
            let packing: String
            let module: String?
        }
        struct Manifest: Decodable {
            let schema: Int
            let repo: String?
            let revision: String?
            let runtime_sha256: String?
            let inventory_sha256: String?
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
        guard (sourceDirectory == nil) == (inventory == nil), !fused || sourceDirectory == nil else {
            throw ModelError("direct VQ row checks require paired source/inventory and scalar fixtures")
        }
        let source = try sourceDirectory.map { try VQCheckpoint(directory: $0, inventory: inventory!) }
        if let source {
            guard source.inventorySHA256 == manifest.inventory_sha256, source.revision == manifest.revision,
                  manifest.fixtures.filter({ $0.module == "model.layers.1.ple.ple_embedding.ngram_embedding.shard_0" }).count == 1 else {
                throw ModelError("VQ source and row reference identify different artifacts")
            }
        }
        let oldCache = MLX.Memory.cacheLimit, oldLimit = MLX.Memory.memoryLimit
        MLX.Memory.cacheLimit = 64_000_000; MLX.Memory.memoryLimit = min(oldLimit, 1_000_000_000)
        defer {
            Stream.gpu.synchronize(); MLX.Memory.clearCache()
            MLX.Memory.cacheLimit = oldCache; MLX.Memory.memoryLimit = oldLimit
        }
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
                    // Local partitions below the D8 SIMD threshold must still
                    // select the original operation's reduction method.
                    let routes = indices.asArray(UInt32.self), topK = indices.dim(1)
                    var pieces: [MLXArray] = []
                    for first in stride(from: 0, to: routes.count, by: 11) {
                        let end = min(first + 11, routes.count)
                        let subset = x[MLXArray((first..<end).map { Int32($0 / topK) })]
                        pieces.append(try projection.operation(subset, expertIDs: Array(routes[first..<end]),
                            topK: 1, dispatchPairs: routes.count)().reshaped([-1, 7]))
                    }
                    c.equal("\(fixture.path) split pairs preserve whole-batch dispatch bits",
                        concatenated(pieces, axis: 0).asData(access: .copy).data,
                        expected.reshaped([-1, 7]).asData(access: .copy).data)
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
                if layout.columns == 160, layout.packing == .bytes {
                    guard source == nil || fixture.module == "model.layers.1.ple.ple_embedding.ngram_embedding.shard_0" else {
                        throw ModelError("direct PLE fixture must identify shard zero")
                    }
                    let direct = try source?.pleTable(0)
                    // Exercise the CPU PLE path with positional reads from
                    // the private, hash-verified file. Retaining the handle in
                    // each closure keeps all row reads tied to that file.
                    let handle = try FileHandle(forReadingFrom: verified)
                    let headerBytes = data.withUnsafeBytes { Int($0.loadUnaligned(as: UInt64.self).littleEndian) }
                    guard headerBytes > 0, headerBytes <= data.count - 8,
                          let header = try JSONSerialization.jsonObject(with: data.subdata(in: 8..<(8 + headerBytes))) as? [String: Any] else {
                        throw ModelError("invalid verified PLE fixture header")
                    }
                    func reader(_ name: String, stride: Int) throws -> VQPLERows.Read {
                        guard let item = header[name] as? [String: Any], let extent = item["data_offsets"] as? [Int],
                              extent.count == 2, extent[0] >= 0, extent[1] - extent[0] == 7 * stride,
                              extent[1] <= data.count - 8 - headerBytes else { throw ModelError("PLE fixture row extent mismatch") }
                        return { row, count in
                            guard (0..<7).contains(row), count == stride else { throw CheckpointReadError.invalidRange }
                            let offset = try ExactRead.tensorOffset(base: 8 + headerBytes + extent[0],
                                length: extent[1] - extent[0], offset: row * stride, count: count)
                            var bytes = Data(count: count)
                            try bytes.withUnsafeMutableBytes { raw in
                                try ExactRead.transfer(into: raw.baseAddress!, offset: offset, count: count) { dst, n, pos in
                                    let got = Foundation.pread(handle.fileDescriptor, dst, n, off_t(pos))
                                    return .init(count: got, error: got < 0 ? errno : 0)
                                }
                            }
                            return bytes
                        }
                    }
                    var words = book.reshaped([-1]).view(dtype: .uint16).asArray(UInt16.self).map(\.littleEndian)
                    let native = try VQPLERows(rowCount: 7, dimensions: layout.dimensions, entries: layout.codebookEntries,
                        codebook: words.withUnsafeMutableBytes { Data($0) }, readCodes: reader("codes", stride: layout.codeRowBytes),
                        readScales: reader("vq_scales", stride: 10))
                    for ids in [[6], [6, 0, 6, 2, 1, 5], (0..<512).map { $0 % 7 }, (0..<8192).map { 6 - $0 % 7 }] {
                        let bits = expected[MLXArray(ids.map(Int32.init))].asType(.bfloat16)
                            .reshaped([-1]).view(dtype: .uint16).asArray(UInt16.self)
                        c.equal("\(fixture.path) native CPU disk PLE \(ids.count) exact BF16 bits", try native.gather(ids), bits)
                        if let direct {
                            c.equal("\(fixture.path) authenticated checkpoint PLE \(ids.count) exact BF16 bits", try direct.gather(ids), bits)
                        }
                    }
                    try handle.close()
                }
                guard ProcessMemory.peakResidentBytes() <= 2_000_000_000 else {
                    throw ModelError("VQ fixture check exceeded its 2 GB component bound")
                }
            }
            if let source {
                c.expect("PLE demanded checkpoint payloads fully verified", source.verifiedFileCount > 0)
                fputs("VQ PLE verified files=\(source.verifiedFileCount) bytes=\(source.verifiedPayloadBytes)\n", stderr)
            }
            return c.report()
        }
    }
}
