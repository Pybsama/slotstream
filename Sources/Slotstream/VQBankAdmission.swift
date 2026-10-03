import Foundation

/// Explicit research admission, independent of the ordinary bank limits.
/// Only the dense composite coordinator may request the larger profile. Its
/// geometry is a hypothesis until full parity and process-footprint gates pass.
package enum VQBankAdmission {
    case standard
    case denseCompositeReinvestment

    package func maximumRows(for layout: VQLayout) throws -> Int {
        switch self {
        case .standard: return layout.maximumResearchBankRows
        case .denseCompositeReinvestment:
            guard layout.dimensions == 4, layout.codebookEntries == 2048,
                  layout.packing == .words32, layout.groupSize == 64,
                  [640, 2560].contains(layout.columns) else {
                throw ModelError("larger VQ bank requires the inspected dense-composite class")
            }
            return 1536
        }
    }

    package var maximumRecordBytes: Int {
        self == .standard ? 1_400_000_000 : 3_000_000_000
    }
    package var maximumProjectionBytes: Int {
        self == .standard ? 512_000_000 : 1_024_000_000
    }
}
