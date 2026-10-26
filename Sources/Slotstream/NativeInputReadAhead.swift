import Foundation
import MLX

/// Bounded next-layer prediction using the current expert input, following
/// Splash 1482f6b. Predictions only arrange reads; true target routing still
/// chooses every expert. No learned correction or retained activation cache.
package enum NativeInputReadAhead {
    package static let reserveBytes = 128 << 20

    package static func configuration(reservedBytes: Int, topK: Int) -> ExpertPrefetchConfiguration {
        var configuration = ExpertPrefetchConfiguration()
        configuration.enabled = true
        configuration.policy = .router
        configuration.tap = .attention
        configuration.inputForecast = true
        configuration.windowLayers = 1
        configuration.strides = []
        configuration.capRecords = 64
        configuration.slotCap = 0
        configuration.issueCapPerTarget = 64
        configuration.topPerLayer = topK
        configuration.lanes = 4
        configuration.threshold = 0
        configuration.adoption = .staging
        configuration.reserveBytes = reservedBytes
        return configuration
    }

    package static func ranked(ids: [Int32], weights: [Float], experts: Int) -> [Int32] {
        precondition(ids.count == weights.count && experts > 0)
        var sums = [Float](repeating: 0, count: experts)
        var order: [Int32] = []
        var seen = [Bool](repeating: false, count: experts)
        for (id, weight) in zip(ids, weights) {
            guard id >= 0, Int(id) < experts, weight.isFinite, weight >= 0 else { continue }
            let i = Int(id)
            if !seen[i] { seen[i] = true; order.append(id) }
            sums[i] += weight
        }
        // Ties retain their first route position, matching stable_sort.
        return order.enumerated().sorted {
            let a = sums[Int($0.element)], b = sums[Int($1.element)]
            return a == b ? $0.offset < $1.offset : a > b
        }.map(\.element)
    }
}

extension Qwen4ExpModel {
    /// The planner charges the complete reservation before solving the cache.
    /// Diagnostics use the same installation with an equal-capacity control.
    package func enableNativeInputReadAhead(reservedBytes: Int) throws {
        guard reservedBytes >= NativeInputReadAhead.reserveBytes, lookahead == nil,
              dflash != nil, pool.expertStore.nativeAffineTiles || pool.expertStore.isQ2 else {
            throw ModelError("Native input read-ahead needs its explicit reserve and an unshared Fast/Q2 DFlash session")
        }
        let configuration = NativeInputReadAhead.configuration(reservedBytes: reservedBytes, topK: cfg.topK)
        let scheduler = ExpertPrefetchScheduler(store: pool.expertStore, pool: pool,
            configuration: configuration, predictor: nil, layers: runLayers, experts: cfg.numExperts)
        let scratchBytes = (pool.expertStore.pieceRowBytes.max() ?? 0) + 2 * ExactRead.pageBytes
        guard scheduler.accounting.capBytes + scratchBytes * configuration.lanes <= reservedBytes else {
            throw ModelError("Native input read-ahead exceeds its scratch reservation")
        }
        let session = ExpertLookaheadSession()
        session.prefetch = scheduler
        session.forecastsPlainPasses = true
        lookahead = session
    }
}
