import Foundation

/// Single-request adaptation of Splash's VerifyBudget (Apache-2.0;
/// Licenses/splash-NOTICE.txt). Prices actual cycles, including SSD waits,
/// and only verifies a useful prefix. It never authorizes an output token.
/// The bounded calibration constants and prior are upstream's single-lane
/// recipe, not measurements of Slotstream. The ordinary decode fallback
/// independently checks whether the whole draft path pays for itself.
package struct DFlashVerifyBudget {
    package init() {}
    private static let prior: [Double] = [0.7, 0, -0.35, -0.8, -0.75, -0.75, -0.85, -0.45]
    private var theta = Self.prior
    private struct Label { let position: Int; let feature: Double; let accepted: Bool }
    private var labels: [Label] = []
    private var next = 0, cycles = 0
    private var weight = 0.0, rows = 0.0, squared = 0.0, time = 0.0, cross = 0.0

    private static func logit(_ p: Double) -> Double {
        let p = min(1 - 1e-6, max(1e-6, p)); return log(p / (1 - p))
    }
    private static func seed(_ rows: Int) -> Double {
        let knots = [1, 2, 4, 8], values = [0.60, 0.69, 0.85, 1.0]
        let upper = (1...3).first { rows <= knots[$0] } ?? 3
        let t = Double(rows - knots[upper - 1]) / Double(knots[upper] - knots[upper - 1])
        return values[upper - 1] + t * (values[upper] - values[upper - 1])
    }
    private var fit: (Double, Double)? {
        guard weight > 0 else { return nil }
        let mr = rows / weight, mt = time / weight
        let spread = max(0, squared / weight - mr * mr), covariance = cross / weight - mr * mt
        let priorSlope = (1 - 0.60) / 7 * mt / Self.seed(Int(mr.rounded()))
        let slope = max(0, (weight * covariance + 5 * priorSlope) / (weight * spread + 5))
        return (mt - slope * mr, slope)
    }
    private func cost(_ rows: Int) -> Double {
        guard let (a, b) = fit else { return Self.seed(rows) }
        return max(a + b * Double(rows), 0.05 * time / weight)
    }
    package func depth(confidence: [Float]) -> Int {
        precondition((1...7).contains(confidence.count))
        if cycles % 32 == 31 { return confidence.count }
        var survival = 1.0, expected = 1.0, best = 1 / cost(1), depth = 0
        for (position, value) in confidence.enumerated() {
            guard value.isFinite else { break }
            let z = theta[0] * Self.logit(Double(value)) + theta[position + 1]
            survival *= 1 / (1 + exp(-z)); expected += survival
            let score = expected / cost(position + 2)
            if score > best { best = score; depth = position + 1 }
        }
        // The existing adaptive policy owns the transition to ordinary
        // decoding. Retain one proposal until it has a measured comparison.
        return max(1, depth)
    }
    package mutating func observe(confidence: [Float], verified: Int, accepted: Int,
                                  seconds: Double, labelsValid: Bool = true) {
        guard (1...7).contains(verified), verified <= confidence.count,
              (0...verified).contains(accepted) else { return }
        let r = Double(verified + 1)
        if seconds.isFinite && seconds > 0 {
            var duration = seconds
            if let (a, b) = fit {
                let predicted = max(a + b * r, 1e-6)
                duration = min(2 * predicted, max(0.5 * predicted, duration))
            }
            weight = 0.97 * weight + 1; rows = 0.97 * rows + r
            squared = 0.97 * squared + r * r; time = 0.97 * time + duration
            cross = 0.97 * cross + r * duration
        }
        if labelsValid {
            // Do not label an unverified proposal after an accepted prefix,
            // or interpret a cancelled/stopped stream as a target rejection.
            for position in 0..<min(verified, accepted + 1) {
                let p = confidence[position]
                guard p.isFinite && (0...1).contains(p) else { continue }
                let label = Label(position: position, feature: Self.logit(Double(p)), accepted: position < accepted)
                if labels.count < 4096 { labels.append(label) }
                else { labels[next] = label; next = (next + 1) % 4096 }
            }
        }
        cycles += 1
        if cycles % 64 == 0 && !labels.isEmpty { refit() }
    }
    private func objective(_ parameters: [Double]) -> Double {
        var result = 0.0
        for label in labels {
            let z = parameters[0] * label.feature + parameters[label.position + 1]
            let margin = label.accepted ? z : -z
            result += margin > 0 ? log1p(exp(-margin)) : -margin + log1p(exp(margin))
        }
        for i in 0..<8 { result += 0.5 * (i == 0 ? 50 : 4) * pow(parameters[i] - Self.prior[i], 2) }
        return result
    }
    private mutating func refit() {
        var current = objective(theta)
        for _ in 0..<16 {
            var gradient = [Double](repeating: 0, count: 8)
            var h = [[Double]](repeating: gradient, count: 8)
            for label in labels {
                let b = label.position + 1
                let p = 1 / (1 + exp(-(theta[0] * label.feature + theta[b])))
                let residual = p - (label.accepted ? 1 : 0), w = p * (1 - p)
                gradient[0] += residual * label.feature; gradient[b] += residual
                h[0][0] += w * label.feature * label.feature
                h[0][b] += w * label.feature; h[b][0] += w * label.feature; h[b][b] += w
            }
            for i in 0..<8 {
                let precision = Double(i == 0 ? 50 : 4)
                gradient[i] += precision * (theta[i] - Self.prior[i]); h[i][i] += precision
            }
            for column in 0..<8 {
                let pivot = (column..<8).max { abs(h[$0][column]) < abs(h[$1][column]) }!
                h.swapAt(column, pivot); gradient.swapAt(column, pivot)
                for row in (column + 1)..<8 {
                    let factor = h[row][column] / h[column][column]
                    for k in column..<8 { h[row][k] -= factor * h[column][k] }
                    gradient[row] -= factor * gradient[column]
                }
            }
            var step = [Double](repeating: 0, count: 8)
            for row in stride(from: 7, through: 0, by: -1) {
                var sum = gradient[row]
                for k in (row + 1)..<8 { sum -= h[row][k] * step[k] }
                step[row] = sum / h[row][row]
            }
            var scale = 1.0, moved = false, largest = 0.0
            for _ in 0..<30 {
                let candidate = zip(theta, step).map { $0 - scale * $1 }
                let value = objective(candidate)
                if value.isFinite && value <= current {
                    largest = zip(candidate, theta).map { abs($0 - $1) }.max()!
                    theta = candidate; current = value; moved = true; break
                }
                scale *= 0.5
            }
            if !moved || largest < 1e-9 { break }
        }
    }
}
