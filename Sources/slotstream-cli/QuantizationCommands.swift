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
    @Option(name: .long, help: "Corrected dense-block reference fixture from Tools/vq_trunk_reference.py")
    var trunkFixtureDirectory: String?
    @Flag(name: .long, help: "Check synthetic native VQ and affine kernels")
    var kernels = false
    func run() throws {
        var reports = [try Diagnostics.quantizationGeometry(), try Diagnostics.quantizationMetadata(),
                       try Diagnostics.quantizationPLEStorage()]
        if kernels { reports.append(try Diagnostics.quantizationKernels()) }
        if let fixtureDirectory {
            reports.append(try Diagnostics.quantizationFixtures(directory: URL(fileURLWithPath: fixtureDirectory)))
        }
        if let fusedFixtureDirectory {
            reports.append(try Diagnostics.quantizationFixtures(directory: URL(fileURLWithPath: fusedFixtureDirectory), fused: true))
        }
        if let recordFixtureDirectory {
            reports.append(try Diagnostics.quantizationRecords(directory: URL(fileURLWithPath: recordFixtureDirectory)))
        }
        if let trunkFixtureDirectory {
            reports.append(try Diagnostics.quantizationTrunk(directory: URL(fileURLWithPath: trunkFixtureDirectory)))
        }
        let encoder = JSONEncoder(); encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        print(String(decoding: try encoder.encode(reports), as: UTF8.self))
        guard reports.allSatisfy(\.passed) else { throw ExitCode.failure }
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
