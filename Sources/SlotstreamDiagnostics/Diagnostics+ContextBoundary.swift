import Foundation
import Slotstream

extension Diagnostics {
    public static func contextBoundaryComponent(modelDir: URL) throws -> CheckReport {
        let result = try ContextBoundaryProbe.run(modelDir: modelDir)
        return CheckReport(name: "context-boundary-component-trained-weights-synthetic-history",
            items: result.checks.keys.sorted().map { CheckItem(name: $0, passed: result.checks[$0]!) },
            measurements: result.measurements)
    }
}
