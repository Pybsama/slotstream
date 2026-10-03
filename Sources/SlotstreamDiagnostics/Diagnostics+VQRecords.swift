import CryptoKit
import Foundation
import MLX
import Slotstream

extension Diagnostics {
    /// Full real expert matrices composed through routed SwiGLU. These
    /// fixtures exercise immutable staging only, not cache lifecycle or a
    /// complete model. No candidate is admitted to Engine.load here.
    public static func quantizationRecords(directory: URL) throws -> CheckReport {
        struct Projection: Decodable {
            let columns: Int, dimensions: Int, entries: Int, group_size: Int
            let packing: String
        }
        struct Fixture: Decodable {
            let path: String, sha256: String
            let bytes: Int, layer: Int
            let expert_ids: [UInt32]
            let projections: [Projection]
        }
        struct Manifest: Decodable {
            let schema: Int
            let runtime_sha256: String
            let fixtures: [Fixture]
        }
        func read(_ path: URL, limit: Int) throws -> Data {
            let file = try FileHandle(forReadingFrom: path)
            defer { try? file.close() }
            guard let bytes = try file.read(upToCount: limit + 1), !bytes.isEmpty, bytes.count <= limit else {
                throw ModelError("VQ record fixture exceeds its bounded read")
            }
            return bytes
        }
        let manifest = try JSONDecoder().decode(Manifest.self,
            from: read(directory.appendingPathComponent("records.json"), limit: 1_000_000))
        guard manifest.schema == 1, manifest.fixtures.count == 2,
              Set(manifest.fixtures.map(\.layer)) == Set([0, 2]),
              manifest.runtime_sha256 == "1685ec90feb24e421c379ae4e3594f659478905d2c1393617990d84d3f514ee8" else {
            throw ModelError("VQ record fixtures need the pinned runtime and both layer families")
        }
        try ModelProcessGuard.acquire()
        guard let vm = ProcessMemory.vmActivity(), vm.reclaimableBytes >= 5_000_000_000 else {
            throw ModelError("VQ record checks need 5 GB actual reclaimable memory")
        }
        let oldCache = MLX.Memory.cacheLimit, oldLimit = MLX.Memory.memoryLimit
        MLX.Memory.cacheLimit = 64_000_000; MLX.Memory.memoryLimit = min(oldLimit, 1_000_000_000)
        defer {
            Stream.gpu.synchronize(); MLX.Memory.clearCache()
            MLX.Memory.cacheLimit = oldCache; MLX.Memory.memoryLimit = oldLimit
        }
        var c = CheckBuilder("quantization-records")
        return try withError {
            for fixture in manifest.fixtures {
                guard fixture.path == "record-\(fixture.layer).safetensors", fixture.bytes > 0,
                      fixture.bytes <= 64_000_000, fixture.expert_ids == [0, 1, 7, 511], fixture.projections.count == 3 else {
                    throw ModelError("unexpected VQ complete-record fixture metadata")
                }
                let data = try read(directory.appendingPathComponent(fixture.path), limit: 64_000_000)
                let digest = SHA256.hash(data: data).map { String(format: "%02x", $0) }.joined()
                guard data.count == fixture.bytes, digest == fixture.sha256 else { throw ModelError("VQ record fixture digest mismatch") }
                let layouts = try fixture.projections.map { p -> VQLayout in
                    guard let packing = VQLayout.Packing(rawValue: p.packing) else { throw ModelError("unknown VQ record packing") }
                    return try VQLayout(columns: p.columns, dimensions: p.dimensions, codebookEntries: p.entries,
                                        groupSize: p.group_size, packing: packing)
                }
                let layout = try VQRecordLayout(layouts)
                let scratch = FileManager.default.temporaryDirectory.appendingPathComponent("slotstream-vq-record-" + UUID().uuidString)
                try FileManager.default.createDirectory(at: scratch, withIntermediateDirectories: false,
                    attributes: [.posixPermissions: 0o700])
                defer { try? FileManager.default.removeItem(at: scratch) }
                let path = scratch.appendingPathComponent("verified.safetensors")
                try data.write(to: path, options: .atomic)
                let arrays = try loadArrays(url: path)
                let names = ["gate_proj", "up_proj", "down_proj"]
                let expectedKeys = Set(names.flatMap { n in ["codes", "codebook", "vq_scales"].map { n + "." + $0 } }
                    + (1...3).flatMap { ["x\($0)", "routes\($0)", "expected\($0)"] })
                guard Set(arrays.keys) == expectedKeys else { throw ModelError("VQ record fixture tensor set mismatch") }
                let codes = names.map { arrays[$0 + ".codes"]! }
                let books = names.map { arrays[$0 + ".codebook"]! }
                let scales = names.map { arrays[$0 + ".vq_scales"]! }
                let batch = try VQRecordBatch(layer: fixture.layer, expertIDs: fixture.expert_ids,
                    layout: layout, codes: codes, books: books, scales: scales)
                c.equal("L\(fixture.layer) complete payload ledger", codes.reduce(0) { $0 + $1.nbytes } + scales.reduce(0) { $0 + $1.nbytes },
                        layout.recordBytes * fixture.expert_ids.count)
                c.equal("L\(fixture.layer) codebooks counted separately", books.reduce(0) { $0 + $1.nbytes }, layout.codebookBytes)
                for count in 1...3 {
                    let x = arrays["x\(count)"]!, routes = arrays["routes\(count)"]!, expected = arrays["expected\(count)"]!
                    guard x.shape == [count, 2560], x.dtype == .bfloat16,
                          routes.shape == [count, 10], routes.dtype == .uint32,
                          expected.shape == [count, 10, 2560], expected.dtype == .bfloat16 else {
                        throw ModelError("VQ record fixture input/output shape mismatch")
                    }
                    let actual = try batch.call(x, routes: routes.asArray(UInt32.self))
                    eval(actual)
                    c.expect("L\(fixture.layer) T\(count) finite composed expert output", all(isFinite(actual)).item(Bool.self))
                    let got = actual.reshaped([-1]).view(dtype: .uint16).asArray(UInt16.self)
                    let want = expected.reshaped([-1]).view(dtype: .uint16).asArray(UInt16.self)
                    c.equal("L\(fixture.layer) T\(count) routed SwiGLU differing elements", zip(got, want).filter { $0 != $1 }.count, 0)
                    let gotHash = got.withUnsafeBytes { SHA256.hash(data: Data($0)).map { String(format: "%02x", $0) }.joined() }
                    let wantHash = want.withUnsafeBytes { SHA256.hash(data: Data($0)).map { String(format: "%02x", $0) }.joined() }
                    c.equal("L\(fixture.layer) T\(count) exact routed SwiGLU bits", gotHash, wantHash)
                }
                // Mutate each caller-owned group independently after admission,
                // before constructing or evaluating an operation. MLXArray is
                // a reference type; retaining the caller's object is insufficient.
                for group in 0..<3 {
                    let inputs = [codes, books, scales].map { $0.map { $0.reshaped($0.shape) } }
                    let owned = try VQRecordBatch(layer: fixture.layer, expertIDs: fixture.expert_ids,
                        layout: layout, codes: inputs[0], books: inputs[1], scales: inputs[2])
                    for value in inputs[group] { value._updateInternal(zeros(like: value)) }
                    let actual = try owned.call(arrays["x1"]!, routes: arrays["routes1"]!.asArray(UInt32.self))
                    let got = actual.reshaped([-1]).view(dtype: .uint16).asArray(UInt16.self)
                    let want = arrays["expected1"]!.reshaped([-1]).view(dtype: .uint16).asArray(UInt16.self)
                    c.equal("L\(fixture.layer) caller \(["codes", "books", "scales"][group]) replacement preserves owned values",
                            zip(got, want).filter { $0 != $1 }.count, 0)
                }
                for operation: () throws -> Void in [
                    { _ = try VQRecordBatch(layer: fixture.layer, expertIDs: [0, 1, 7, 7], layout: layout, codes: codes, books: books, scales: scales) },
                    { _ = try VQRecordBatch(layer: fixture.layer, expertIDs: fixture.expert_ids, layout: layout, codes: Array(codes.prefix(2)), books: books, scales: scales) },
                    { _ = try batch.call(arrays["x1"]!, routes: Array(repeating: 512, count: 10)) }
                ] {
                    do { try operation(); c.expect("invalid complete record or route refused", false) }
                    catch { c.expect("invalid complete record or route refused", true) }
                }
                guard ProcessMemory.peakResidentBytes() <= 2_000_000_000 else {
                    throw ModelError("VQ record check exceeded its 2 GB component bound")
                }
            }
            return c.report()
        }
    }
}
