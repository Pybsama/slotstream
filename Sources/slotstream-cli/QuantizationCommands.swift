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
    @Flag(name: .long, help: "Check synthetic native VQ and affine kernels")
    var kernels = false
    func run() throws {
        var reports = [try Diagnostics.quantizationGeometry(), try Diagnostics.quantizationMetadata()]
        if kernels { reports.append(try Diagnostics.quantizationKernels()) }
        if let fixtureDirectory {
            reports.append(try Diagnostics.quantizationFixtures(directory: URL(fileURLWithPath: fixtureDirectory)))
        }
        if let fusedFixtureDirectory {
            reports.append(try Diagnostics.quantizationFixtures(directory: URL(fileURLWithPath: fusedFixtureDirectory), fused: true))
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
