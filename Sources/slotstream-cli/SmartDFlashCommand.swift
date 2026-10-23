import ArgumentParser
import CryptoKit
import Foundation
import MLX
import Slotstream

/// Sequential native comparison through the production Engine, tokenizer,
/// sampler and cache. This explicit instrument does not promote a new default.
struct SmartDFlashCheck: ParsableCommand {
    static let configuration = CommandConfiguration(commandName: "smart-dflash-check",
        abstract: "Compare native Fast or Smart generation on explicit local cases")
    @Option var method: String = "dflash"
    @Option var memoryGB: Double = 10
    @Option var maxContext: Int = 32768
    @Option var cases: String
    @Option var output: String
    @Option var model: String = PinnedModel.name
    @Option var dumpFirstDraft: String?
    @Option var prefixCacheDir: String?
    @Flag(help: "Download the selected pinned draft before the comparison") var installDraft = false
    @Flag(help: "Diagnostic target-only control, retaining the same priced memory plan") var disableDraft = false
    @Option(help: "Diagnostic next-input read-ahead: off, reserve (capacity control), on") var nativeReadAhead = "off"

    struct Probe: Decodable {
        let id: String
        let prompt: String
        let maxTokens: Int
        var temperature: Float?
        var seed: UInt64?
        var stop: [String]?
        var cancelAfter: Int?
        var tool: ProbeTool?
        var imagePaths: [String]?
        var conversation: String?
    }
    struct ProbeTool: Decodable {
        let name: String
        let description: String
        let parameters: [String: String]
        var definition: ToolDefinition {
            ToolDefinition(name: name, description: description, parameters: .object([
                "type": .string("object"),
                "properties": .object(parameters.mapValues { .object(["type": .string($0)]) }),
                "required": .array(parameters.keys.sorted().map { .string($0) }),
                "additionalProperties": .bool(false)]))
        }
    }
    func run() throws {
        guard ["off", "reserve", "on"].contains(nativeReadAhead),
              nativeReadAhead == "off" || ["fast", "q2"].contains(method) else {
            throw ValidationError("Native read-ahead requires Fast/Q2 and off, reserve or on")
        }
        guard ["plain", "mtp", "dflash", "q2", "fast"].contains(method), memoryGB.isFinite,
              (10...33).contains(memoryGB), [8192, 32768].contains(maxContext) else {
            throw ValidationError("Use plain, mtp, dflash, q2 or fast, a 10–33 GB explicit budget, and 8192 or 32768 context tokens")
        }
        let probes = try JSONDecoder().decode([Probe].self, from: Data(contentsOf: URL(fileURLWithPath: cases)))
        guard !probes.isEmpty, probes.count <= 100,
              probes.allSatisfy({ !$0.id.isEmpty && (1...4096).contains($0.maxTokens) && $0.prompt.utf8.count <= 500_000 && ($0.imagePaths?.count ?? 0) <= 1 }) else {
            throw ValidationError("Cases must be bounded prompts with explicit output limits")
        }
        guard !FileManager.default.fileExists(atPath: output),
              dumpFirstDraft.map({ !FileManager.default.fileExists(atPath: $0) }) ?? true else {
            throw ValidationError("Use new receipt and draft-dump paths; existing evidence is never overwritten")
        }
        guard ["dflash", "q2", "fast"].contains(method) || (!installDraft && dumpFirstDraft == nil) else {
            throw ValidationError("Draft installation and capture require --method dflash, q2 or fast")
        }
        let modelDirectory = ModelLocator.resolve(method == "fast" ? PinnedFastModel.name : model)
        if method == "fast" {
            let store = DFlashDeployment.store(for: modelDirectory)
            if installDraft { try store.download(log: { print($0) }) }
            try store.verify()
        }
        if method == "dflash" || method == "q2" {
            let store = SmartDFlashDeployment.store(for: modelDirectory)
            if installDraft { try store.download(log: { print($0) }) }
            try store.verify()
        }
        let hasImages = probes.contains { !($0.imagePaths?.isEmpty ?? true) }
        let resources: PackMemoryProfile = method == "fast" ? .fast : method == "q2" ? .q2 : method == "dflash" ? .smartDFlash : .original
        let machine = Machine.current()
        guard let availableGB = machine.availableGB, availableGB >= memoryGB + 3 else { throw ModelError("Comparison needs target plus 3 GB reclaimable memory") }
        let plan = try Planner.plan(resources: resources, expertsPerLayer: nil, poolGB: nil, memoryGB: memoryGB,
            ramGB: machine.ramGB, workingSetGB: machine.workingSetGB, availableGB: machine.availableGB,
            mtp: method == "mtp" ? .on : .off, mtpAvailable: method == "mtp",
            vision: hasImages ? .on : .off, visionAvailable: hasImages,
            maxContextTokens: maxContext, qualification: false,
            decodeLookahead: nativeReadAhead == "off" ? .off : .reserved(bytes: NativeInputReadAhead.reserveBytes),
            mtpExperts: .automatic)
        print(plan.banner())
        let sem = DispatchSemaphore(value: 0)
        var outcome: Result<Void, Error> = .success(())
        Task {
            do {
                let launched = Date()
                let engine = try await Engine(modelDir: modelDirectory, plan: plan)
                if nativeReadAhead == "on" {
                    try engine.model.enableNativeInputReadAhead(reservedBytes: plan.lookaheadReserveBytes)
                }
                if disableDraft { engine.generator.speculationEnabled = false }
                // Identical, explicitly priced pass shapes in all methods.
                engine.generator.prefillChunk = min(256, plan.prefillChunk)
                engine.generator.footprintSampling = true
                if let prefixCacheDir {
                    _ = try engine.enablePersistentPrefixCache(.init(directory: URL(fileURLWithPath: prefixCacheDir)))
                }
                var didDump = false
                var tensors: [String: MLXArray] = [:]
                if let dumpFirstDraft {
                    engine.model.dflash?.debugSink = { name, value in
                        guard !didDump else { return }
                        eval(value)
                        if name == "context_features", let previous = tensors[name] {
                            let joined = concatenated([previous, value], axis: 1)
                            tensors[name] = joined[0..., max(0, joined.dim(1) - 2047)..<joined.dim(1), 0...]
                            eval(tensors[name]!)
                        } else { tensors[name] = value }
                        if name == "draft_proposals" {
                            do { try save(arrays: tensors, url: URL(fileURLWithPath: dumpFirstDraft)); didDump = true; tensors.removeAll() }
                            catch { print("draft dump failed: \(error)") }
                        }
                    }
                }
                let loadSeconds = Date().timeIntervalSince(launched)
                var rows: [[String: Any]] = []
                var conversations: [String: [ChatMessage]] = [:]
                for probe in probes {
                    let control = try engine.beginRequest()
                    let tools = probe.tool.map { [$0.definition] } ?? []
                    var message = ChatMessage(role: "user", content: probe.prompt)
                    message.images = try (probe.imagePaths ?? []).map { path in
                        let handle = try FileHandle(forReadingFrom: URL(fileURLWithPath: path))
                        defer { try? handle.close() }
                        let size = try handle.seekToEnd()
                        guard size > 0, size <= UInt64(VisionPreprocess.maxImageBytes) else {
                            throw ValidationError("Image exceeds the bounded native image input size")
                        }
                        try handle.seek(toOffset: 0)
                        guard let data = try handle.readToEnd(), !data.isEmpty else {
                            throw ValidationError("Image input became empty while reading")
                        }
                        return data.base64EncodedString()
                    }
                    let history = probe.conversation.flatMap { conversations[$0] } ?? []
                    let messages = history + [message]
                    let (ids, vision) = try engine.encodeChatWithVision(messages, tools: tools, thinking: false, request: control)
                    var params = SampleParams.greedy
                    params.maxTokens = probe.maxTokens
                    params.temperature = probe.temperature ?? 0
                    params.seed = probe.seed
                    params.stop = probe.stop ?? []
                    var callbacks = 0, streamed = ""
                    let splitter = ToolCallSplitter(tools: tools.map(\.schema))
                    var toolCalls: [[String: Any]] = [], malformed = false
                    func collect(_ events: [ToolStreamEvent]) {
                        for event in events {
                            switch event {
                            case .toolCall(let call): toolCalls.append(["name": call.name, "arguments_json": call.inputJSON])
                            case .malformed: malformed = true
                            default: break
                            }
                        }
                    }
                    let before = ProcessMemory.vmActivity()
                    let start = Date()
                    let (text, tokens, stats) = engine.generate(promptIds: ids, params: params, vision: vision,
                        onToken: { _, delta in
                            callbacks += 1; streamed += delta
                            collect(splitter.push(delta))
                            return probe.cancelAfter.map { callbacks < $0 } ?? true
                        }, request: control)
                    let after = ProcessMemory.vmActivity()
                    if let conversation = probe.conversation, stats.finishReason == "stop",
                       stats.runtimeError == nil, probe.cancelAfter == nil {
                        conversations[conversation] = messages + [ChatMessage(role: "assistant", content: text)]
                    }
                    collect(splitter.flush())
                    let statsJSON = try JSONSerialization.jsonObject(with: JSONEncoder().encode(stats))
                    rows.append(["id": probe.id, "prompt_ids": ids, "text": text, "tokens": tokens,
                        "streamed": streamed, "callbacks": callbacks, "stats": statsJSON,
                        "tool_calls": toolCalls, "malformed_tool_call": malformed,
                        "elapsed_seconds": Date().timeIntervalSince(start),
                        "swapins_delta": (after?.swapins ?? 0) - (before?.swapins ?? 0),
                        "swapouts_delta": (after?.swapouts ?? 0) - (before?.swapouts ?? 0)])
                    let receipt: [String: Any] = ["method": method, "memory_gb": memoryGB, "draft_disabled": disableDraft,
                        "native_input_read_ahead": nativeReadAhead,
                        "plan": plan.json(), "load_seconds": loadSeconds, "runs": rows,
                        "draft_dumped": didDump, "complete": rows.count == probes.count]
                    try JSONSerialization.data(withJSONObject: receipt, options: [.prettyPrinted, .sortedKeys])
                        .write(to: URL(fileURLWithPath: output), options: .atomic)
                    print("\(probe.id): \(stats.finishReason), \(tokens.count) tokens, peak \(stats.peakMemoryGB) GB")
                    if let error = stats.runtimeError { throw ModelError(error) }
                    guard stats.peakMemoryGB <= memoryGB, !stats.memoryPressureCancelled else { throw ModelError("Comparison exceeded its physical memory budget") }
                }
                guard dumpFirstDraft == nil || didDump else { throw ModelError("No draft fixture was captured") }
            } catch { outcome = .failure(error) }
            sem.signal()
        }
        sem.wait(); try outcome.get()
    }
}

/// Independent draft-network check using previously captured native inputs.
struct SmartDFlashReplay: ParsableCommand {
    static let configuration = CommandConfiguration(commandName: "smart-dflash-replay",
        abstract: "Replay a bounded Smart draft fixture without loading target weights")
    @Option var fixture: String
    @Option var output: String
    @Option(help: "Comma-separated original projection chunk lengths") var contextChunks: String
    @Option var model: String = PinnedModel.name

    func run() throws {
        guard !FileManager.default.fileExists(atPath: output) else { throw ValidationError("Use a new output path") }
        let parts = contextChunks.split(separator: ",", omittingEmptySubsequences: false)
        let chunks = parts.compactMap { Int($0) }
        guard chunks.count == parts.count, !chunks.isEmpty, chunks.count <= 2047,
              chunks.allSatisfy({ (1...2047).contains($0) }), chunks.reduce(0, +) <= 2047 else {
            throw ValidationError("Use bounded positive context chunk lengths")
        }
        let url = URL(fileURLWithPath: fixture)
        let size = try url.resourceValues(forKeys: [.fileSizeKey]).fileSize ?? 0
        guard (1...100_000_000).contains(size), (Machine.current().availableGB ?? 0) >= 6 else {
            throw ValidationError("Replay needs a bounded fixture and 6 GB reclaimable memory")
        }
        try ModelProcessGuard.acquire()
        MLX.Memory.cacheLimit = 2_000_000_000
        var arrays = try loadArrays(url: url)
        guard let features = arrays["context_features"], features.shape == [1, chunks.reduce(0, +), 12800],
              features.dtype == .bfloat16, let endArray = arrays["context_end"], endArray.size == 1,
              let noise = arrays["noise_embedding"], let oldHidden = arrays["draft_hidden"],
              oldHidden.ndim == 3, (1...7).contains(oldHidden.dim(1)) else { throw ValidationError("Invalid Smart draft fixture") }
        let end = endArray.item(Int.self)
        guard end >= features.dim(1), end <= 32768 else { throw ValidationError("Invalid context extent") }
        let directory = ModelLocator.resolve(model)
        try SmartDFlashDeployment.store(for: directory).verify()
        let config = try ModelConfig.parse(Data(contentsOf: directory.appendingPathComponent("config.json")), label: "Smart replay")
        let draft = try DFlashDraft(directory: DFlashDeployment.directory(for: directory), target: config)
        let context = DFlashDraft.Context()
        var at = 0
        for count in chunks {
            draft.append(features[0..., at..<(at + count), 0...], endingAt: end - features.dim(1) + at + count, to: context)
            at += count
        }
        arrays["draft_hidden"] = try draft.hiddenStates(noise: noise, depth: oldHidden.dim(1), context: context)
        eval(arrays["draft_hidden"]!)
        try save(arrays: arrays, url: URL(fileURLWithPath: output))
        print("Replayed \(chunks.count) context chunks and \(oldHidden.dim(1)) draft rows without target weights")
    }
}

/// Independent GGML fixture comparison without allocating a model. The
/// fixture supplies decoded reference values, never inferred from our kernel.
struct Q2FormatCheck: ParsableCommand {
    static let configuration = CommandConfiguration(commandName: "q2-format-check",
        abstract: "Check native packed Q2 deployment formats against independent fixtures")
    @Option var fixtures: String
    @Option var policyFixtures: String?
    @Option var mixFixtures: String?
    struct MixFixture: Decodable { let format: UInt32; let input: String; let expected: String }
    struct PolicyFixture: Decodable { let confidence: [Float]; let depth: Int; let accepted: Int; let seconds: Double }
    struct Fixture: Decodable {
        let format: UInt32
        let bytes: String
        let columns: Int
        let rows: Int
        let expected: [Float]
        let input: [Float]
        let product: [Float]
        let source: String
    }
    func run() throws {
        try admissionChecks()
        let cases = try JSONDecoder().decode([Fixture].self, from: Data(contentsOf: URL(fileURLWithPath: fixtures)))
        guard cases.count == Q2GGUFFormat.allCases.count,
              Set(cases.map(\.format)) == Set(Q2GGUFFormat.allCases.map(\.rawValue)) else {
            throw ValidationError("Fixtures must cover every admitted deployment format")
        }
        MLX.Memory.cacheLimit = 64 << 20
        for f in cases {
            guard let format = Q2GGUFFormat(rawValue: f.format), let data = Data(base64Encoded: f.bytes),
                  (1...32).contains(f.rows), f.columns == 256,
                  f.expected.count == f.rows * f.columns, f.input.count == f.columns,
                  f.product.count == f.rows, data.count == f.rows * f.columns / format.block * format.bytes else {
                throw ValidationError("Invalid bounded format fixture")
            }
            let bytes = MLXArray(data, [data.count], dtype: .uint8)
            let decoded = Q2GGUFLinear.decode(bytes, format: format, count: f.expected.count).asArray(Float.self)
            let difference = zip(decoded, f.expected).map { abs($0 - $1) }.max()!
            let scale = f.expected.map(abs).max()!
            guard decoded.allSatisfy(\.isFinite), difference <= max(1e-7, scale * 2e-6) else {
                throw ValidationError("Format \(format): decoder error \(difference)")
            }
            let linear = Q2GGUFLinear(bytes: bytes, format: format, rows: f.rows, columns: f.columns)
            let actual = linear(MLXArray(f.input, [1, f.columns])).asArray(Float.self)
            let productError = zip(actual, f.product).map { abs($0 - $1) }.max()!
            guard actual.allSatisfy(\.isFinite), productError <= max(1e-5, f.product.map(abs).max()! * 2e-5) else {
                throw ValidationError("Format \(format): matvec error \(productError)")
            }
            let routes: [Int32] = [1, 0, 1, 0, 1, 0]
            let batched = Q2GGUFLinear.gather(MLXArray(f.input + f.input + f.input, [3, f.columns]),
                bytes: bytes, format: format, rows: f.rows / 2, columns: f.columns,
                indices: MLXArray(routes), repeatInput: 2).asArray(Float.self)
            let routedExpected = routes.flatMap { id in
                Array(f.product[(Int(id) * f.rows / 2)..<((Int(id) + 1) * f.rows / 2)])
            }
            guard zip(batched, routedExpected).allSatisfy({ abs($0 - $1) <= max(1e-5, abs($1) * 2e-5) }) else {
                throw ValidationError("Routed projection mismatch for \(format)")
            }
            var halfReference: [Float] = []
            for row in 0..<f.rows {
                var sum: Float = 0
                for col in 0..<f.columns {
                    let w = Float(Float16(f.expected[row * f.columns + col]))
                    let x = Float(Float16(f.input[col]))
                    sum += w * x
                }
                halfReference.append(sum)
            }
            for count in [2, 3, 5] {
                let tile = linear(MLXArray(Array(repeating: f.input, count: count).flatMap { $0 }, [count, f.columns])).asArray(Float.self)
                guard zip(tile, Array(repeating: halfReference, count: count).flatMap({ $0 })).allSatisfy({
                    $0.isFinite && abs($0 - $1) <= max(2e-5, abs($1) * 5e-5)
                }) else { throw ValidationError("Staged matrix mismatch for \(format) at \(count) rows") }
            }
            print("\(format): decode \(difference), matvec \(productError), routed batch PASS")
            if Q2PackedExperts.enabled, ![Q2GGUFFormat.f32, .f16, .bf16].contains(format) {
                let rowData = (0..<64).reduce(into: Data()) { result, row in
                    let start = row % f.rows * f.columns / format.block * format.bytes
                    result.append(data[start..<(start + f.columns / format.block * format.bytes)])
                }
                guard let tiled = Q2ResidentWeights(raw: MLXArray(rowData, [rowData.count], dtype: .uint8),
                    format: format, rows: 64, columns: f.columns) else { throw ValidationError("Resident tile missing") }
                for count in [1, 2, 3, 8, 9] {
                    let inputs = MLXArray(Array(repeating: f.input, count: count).flatMap { $0 }, [count, f.columns]).asType(.bfloat16)
                    let rounded = inputs[0].asType(.float32).asArray(Float.self)
                    let register = NativeProjectionPolicy.useRegister(rows: 64, columns: f.columns,
                        batch: count, format: format)
                    var expected: [Float] = []
                    for row in 0..<64 {
                        var sum: Float = 0
                        for col in 0..<f.columns {
                            let decoded = f.expected[(row % f.rows) * f.columns + col]
                            // Register kernels apply coefficients in FP32;
                            // staged tiles materialize weights through FP16.
                            sum += rounded[col] * (register ? decoded : Float(Float16(decoded)))
                        }
                        expected.append(sum)
                    }
                    let actual = tiled(inputs).asType(.float32).asArray(Float.self)
                    let scale = expected.map(abs).max()!
                    let error = zip(actual, Array(repeating: expected, count: count).flatMap { $0 }).map { abs($0 - $1) }.max()!
                    guard actual.allSatisfy(\.isFinite), error <= max(2e-5, scale * 0.008) else {
                        throw ValidationError("Resident tile mismatch for \(format), rows \(count): \(error), scale \(scale)")
                    }
                    let full = tiled(inputs, outputType: .float32).asArray(Float.self)
                    let fullError = zip(full, Array(repeating: expected, count: count).flatMap { $0 }).map { abs($0 - $1) }.max()!
                    guard full.allSatisfy(\.isFinite), fullError <= max(2e-5, scale * 5e-5) else {
                        throw ValidationError("FP32 head tile mismatch for \(format): \(fullError)")
                    }
                }
                print("\(format): packed resident tiles match independent arithmetic, 1/2/3/8/9 rows")
            }
        }
        if let mixFixtures {
            let fixtures = try JSONDecoder().decode([MixFixture].self, from: Data(contentsOf: URL(fileURLWithPath: mixFixtures)))
            guard fixtures.count == 2 else { throw ValidationError("Two bounded Q8 fixtures required") }
            for fixture in fixtures {
                guard let format = Q2GGUFFormat(rawValue: fixture.format),
                      let input = Data(base64Encoded: fixture.input), let expected = Data(base64Encoded: fixture.expected),
                      input.count <= 65536, expected.count <= 65536 else { throw ValidationError("Invalid Q8 fixture") }
                guard try Q2MixQuantization.convert(input, format: format) == expected else {
                    throw ValidationError("Q8 preparation differs from independent Splash oracle")
                }
            }
            for bits: UInt16 in [0x7fc0, 0x7f80, 0xff80, 0x7f7f] {
                let bad = withUnsafeBytes(of: bits.littleEndian) { Data($0) }
                do {
                    _ = try Q2MixQuantization.convert((0..<32).reduce(into: Data()) { d, _ in d.append(bad) }, format: .bf16)
                    throw ValidationError("Invalid Q8 source accepted")
                } catch is ModelError { }
            }
            print("Q8 mixing preparation: exact upstream bytes; nonfinite and overflowing scales refused")
        }
        if let policyFixtures {
            let sequence = try JSONDecoder().decode([PolicyFixture].self,
                from: Data(contentsOf: URL(fileURLWithPath: policyFixtures)))
            guard (128...4096).contains(sequence.count) else { throw ValidationError("Bounded policy sequence required") }
            var policy = DFlashVerifyBudget()
            for (i, row) in sequence.enumerated() {
                guard row.confidence.count == 7, policy.depth(confidence: row.confidence) == row.depth else {
                    throw ValidationError("Upstream verify-budget mismatch at cycle \(i)")
                }
                policy.observe(confidence: row.confidence, verified: row.depth,
                    accepted: row.accepted, seconds: row.seconds)
            }
            print("Verify budget matches upstream across \(sequence.count) cycles and online refits")
        }
    }
    private func admissionChecks() throws {
        let fm = FileManager.default
        let root = fm.temporaryDirectory.appendingPathComponent("q2-admission-" + UUID().uuidString)
        try fm.createDirectory(at: root, withIntermediateDirectories: false)
        defer { try? fm.removeItem(at: root) }
        let file = root.appendingPathComponent("fixture.gguf")
        func fixture(alignment: UInt64? = nil) -> Data {
            var bytes = Data()
            func integer<T: FixedWidthInteger>(_ number: T) {
                var value = number.littleEndian
                withUnsafeBytes(of: &value) { bytes.append(contentsOf: $0) }
            }
            func string(_ value: String) { integer(UInt64(value.utf8.count)); bytes.append(contentsOf: value.utf8) }
            integer(UInt32(0x46554747)); integer(UInt32(3)); integer(UInt64(1)); integer(UInt64(alignment == nil ? 0 : 1))
            if let alignment { string("general.alignment"); integer(UInt32(10)); integer(alignment) }
            string("fixture"); integer(UInt32(2)); integer(UInt64(4)); integer(UInt64(1)); integer(UInt32(0)); integer(UInt64(0))
            while !bytes.count.isMultiple(of: 32) { bytes.append(0) }
            for value: Float in [1, 2, 3, 4] { integer(value.bitPattern) }
            return bytes
        }
        func refuses(_ name: String, _ action: () throws -> Void) throws {
            do { try action() } catch { return }
            throw ValidationError("Q2 admission accepted \(name)")
        }
        let data = fixture(), digest = SHA256.hash(data: fixture()).map { String(format: "%02x", $0) }.joined()
        try data.write(to: file)
        let owner = try Q2GGUFFile(url: file, expectedSize: Int64(data.count), expectedSHA256: digest)
        try owner.verifyUnchanged()
        try refuses("wrong hash") { _ = try Q2GGUFFile(url: file, expectedSHA256: String(repeating: "0", count: 64)) }
        try refuses("wrong length") { _ = try Q2GGUFFile(url: file, expectedSize: Int64(data.count + 1)) }
        try refuses("cancelled authentication") { _ = try Q2GGUFFile(url: file, expectedSHA256: digest, shouldContinue: { false }) }
        let link = root.appendingPathComponent("link.gguf")
        try fm.createSymbolicLink(at: link, withDestinationURL: file)
        try refuses("symlink") { _ = try Q2GGUFFile(url: link) }
        let handle = try FileHandle(forWritingTo: file)
        try handle.seek(toOffset: UInt64(data.count - 1)); try handle.write(contentsOf: Data([1])); try handle.close()
        try refuses("mutated owned payload") { try owner.verifyUnchanged() }
        for (name, bad) in [("short header", Data(data.prefix(20))), ("truncated tensor", Data(data.dropLast())),
                            ("overflowing alignment", fixture(alignment: UInt64.max))] {
            try bad.write(to: file)
            try refuses(name) { _ = try Q2GGUFFile(url: file) }
        }
        print("Q2 admission: complete hash, cancellation, truncation, overflow, symlink and mutation PASS")
    }

}
