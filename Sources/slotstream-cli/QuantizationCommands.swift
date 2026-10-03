import ArgumentParser
import Foundation
import Slotstream
import SlotstreamDiagnostics

struct QuantizationCheck: ParsableCommand {
    static let configuration = CommandConfiguration(commandName: "quantization-check",
        abstract: "Check candidate layout and native decoding; does not enable or qualify a new model pack")
    @Option(name: .long, help: "Pinned row fixtures from Tools/quantization_fixture.py")
    var fixtureDirectory: String?
    @Option(name: .long, help: "Pinned fused binding fixtures from Tools/vq_fused_reference.py")
    var fusedFixtureDirectory: String?
    @Option(name: .long, help: "Complete real expert records from Tools/vq_record_reference.py")
    var recordFixtureDirectory: String?
    @Option(name: .long, help: "Pinned large-prefill expert fixtures from Tools/vq_prefill_reference.py")
    var prefillFixtureDirectory: String?
    @Option(name: .long, help: "Corrected dense-block reference fixture from Tools/vq_trunk_reference.py")
    var trunkFixtureDirectory: String?
    @Option(name: .long, help: "Research-only pinned VQ download to check against record and/or row fixtures")
    var sourceDirectory: String?
    @Option(name: .long, help: "Exact inspected inventory.json for the research VQ download")
    var sourceInventory: String?
    @Flag(name: .long, help: "Check synthetic native VQ and affine kernels")
    var kernels = false
    func validate() throws {
        guard (sourceDirectory == nil) == (sourceInventory == nil) else {
            throw ValidationError("--source-directory and --source-inventory must be provided together")
        }
        if sourceDirectory != nil {
            guard recordFixtureDirectory != nil || fixtureDirectory != nil,
                  fusedFixtureDirectory == nil, trunkFixtureDirectory == nil, prefillFixtureDirectory == nil, !kernels else {
                throw ValidationError("direct source checks require record and/or row fixtures only")
            }
        }
    }
    func run() throws {
        let source = sourceDirectory.map { URL(fileURLWithPath: $0) }
        let inventory = sourceInventory.map { URL(fileURLWithPath: $0) }
        var reports = [try Diagnostics.quantizationGeometry(), try Diagnostics.quantizationMetadata(),
                       try Diagnostics.quantizationPLEStorage(), try Diagnostics.quantizationTensorFile()]
        if kernels {
            reports.append(try Diagnostics.quantizationKernels())
            reports.append(try Diagnostics.quantizationCandidateArithmetic())
        }
        if let fixtureDirectory {
            reports.append(try Diagnostics.quantizationFixtures(directory: URL(fileURLWithPath: fixtureDirectory),
                                                               sourceDirectory: source, inventory: inventory))
        }
        if let fusedFixtureDirectory {
            reports.append(try Diagnostics.quantizationFixtures(directory: URL(fileURLWithPath: fusedFixtureDirectory), fused: true))
        }
        if let recordFixtureDirectory {
            reports.append(try Diagnostics.quantizationRecords(directory: URL(fileURLWithPath: recordFixtureDirectory),
                                                              sourceDirectory: source, inventory: inventory))
        }
        if let prefillFixtureDirectory {
            reports.append(try Diagnostics.quantizationRecords(directory: URL(fileURLWithPath: prefillFixtureDirectory), prefill: true))
        }
        if let trunkFixtureDirectory {
            reports.append(try Diagnostics.quantizationTrunk(directory: URL(fileURLWithPath: trunkFixtureDirectory)))
        }
        let encoder = JSONEncoder(); encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        print(String(decoding: try encoder.encode(reports), as: UTF8.self))
        guard reports.allSatisfy(\.passed) else { throw ExitCode.failure }
    }
}

struct QuantizationModelCheck: ParsableCommand {
    static let configuration = CommandConfiguration(commandName: "quantization-model-check",
        abstract: "Check research VQ complete-stack parity; does not enable a candidate pack")
    @Option(name: .long) var sourceDirectory: String
    @Option(name: .long) var sourceInventory: String
    @Option(name: .long) var fixtureDirectory: String
    @Option(name: .long) var output: String
    @Flag(name: .long, help: "Use the fixed 512-row complete-prefill hash fixture") var prefill = false
    @Flag(name: .long, help: "Compare actual greedy generation and every retained state boundary") var greedy = false
    @Option(name: .long, help: "Frozen bench/quantization/greedy-v1.json, required with --greedy") var generationProfile: String?
    func validate() throws {
        guard !(prefill && greedy), greedy == (generationProfile != nil) else {
            throw ValidationError("--prefill and --greedy are exclusive; --greedy requires --generation-profile")
        }
    }
    func run() throws {
        if greedy, let generationProfile {
            print(String(decoding: try Diagnostics.quantizationGeneration(source: URL(fileURLWithPath: sourceDirectory),
                inventory: URL(fileURLWithPath: sourceInventory), profileURL: URL(fileURLWithPath: generationProfile),
                fixtureDirectory: URL(fileURLWithPath: fixtureDirectory), output: URL(fileURLWithPath: output)), as: UTF8.self))
            return
        }
        if prefill {
            print(String(decoding: try Diagnostics.quantizationPrefillModel(source: URL(fileURLWithPath: sourceDirectory),
                inventory: URL(fileURLWithPath: sourceInventory), fixtureDirectory: URL(fileURLWithPath: fixtureDirectory),
                output: URL(fileURLWithPath: output)), as: UTF8.self))
            return
        }
        print(String(decoding: try Diagnostics.quantizationModel(source: URL(fileURLWithPath: sourceDirectory),
            inventory: URL(fileURLWithPath: sourceInventory), fixtureDirectory: URL(fileURLWithPath: fixtureDirectory),
            output: URL(fileURLWithPath: output)), as: UTF8.self))
    }
}

struct QuantizationBench: ParsableCommand {
    static let configuration = CommandConfiguration(commandName: "quantization-bench",
        abstract: "Run the bounded synthetic screen-v1 kernel timings; no model pack is qualified")
    @Option(name: .long, help: "Run fused-v2 instead, requiring exact binding fixtures from Tools/vq_fused_reference.py")
    var fusedFixtureDirectory: String?
    func run() throws {
        print(String(decoding: try Diagnostics.quantizationBench(
            fusedFixtureDirectory: fusedFixtureDirectory.map { URL(fileURLWithPath: $0) }), as: UTF8.self))
    }
}

struct QuantizationLogits: ParsableCommand {
    static let configuration = CommandConfiguration(commandName: "quantization-logits",
        abstract: "Export bounded full-vocabulary baseline logits for a frozen quantization pilot")
    @Option(name: .long, help: "Existing pinned 4-bit checkpoint directory")
    var model: String
    @Option(name: .long, help: "Frozen JSON token list, at most 2048 tokens")
    var tokens: String
    @Option(name: .long, help: "New output directory for logits and the raw receipt")
    var output: String
    func run() throws {
        print(String(decoding: try Diagnostics.quantizationLogits(modelDir: URL(fileURLWithPath: model),
            tokensFile: URL(fileURLWithPath: tokens), output: URL(fileURLWithPath: output)), as: UTF8.self))
    }
}
