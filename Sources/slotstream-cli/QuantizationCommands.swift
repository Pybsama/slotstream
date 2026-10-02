import ArgumentParser
import Foundation
import Slotstream
import SlotstreamDiagnostics

struct QuantizationCheck: ParsableCommand {
    static let configuration = CommandConfiguration(commandName: "quantization-check",
        abstract: "Check candidate layout and native decoding; does not enable or qualify a new model pack")
    @Option(name: .long, help: "Pinned row fixtures from Tools/quantization_fixture.py")
    var fixtureDirectory: String?
    @Flag(name: .long, help: "Check synthetic native VQ and affine kernels")
    var kernels = false
    func run() throws {
        var reports = [try Diagnostics.quantizationGeometry(), try Diagnostics.quantizationMetadata()]
        if kernels { reports.append(try Diagnostics.quantizationKernels()) }
        if let fixtureDirectory {
            reports.append(try Diagnostics.quantizationFixtures(directory: URL(fileURLWithPath: fixtureDirectory)))
        }
        let encoder = JSONEncoder(); encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        print(String(decoding: try encoder.encode(reports), as: UTF8.self))
        guard reports.allSatisfy(\.passed) else { throw ExitCode.failure }
    }
}

struct QuantizationBench: ParsableCommand {
    static let configuration = CommandConfiguration(commandName: "quantization-bench",
        abstract: "Run the bounded synthetic screen-v1 kernel timings; no model pack is qualified")
    func run() throws {
        print(String(decoding: try Diagnostics.quantizationBench(), as: UTF8.self))
    }
}
