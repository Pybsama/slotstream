import Foundation

/// Bounded adaptation of Splash's VerifyBudget (Apache-2.0;
/// Licenses/splash-NOTICE.txt). Prices actual cycles, including SSD waits,
/// and only verifies a useful prefix. It never authorizes an output token.
/// The bounded calibration constants and prior are upstream's single-lane
/// recipe, not measurements of Slotstream. An anchor-only target pass is a
/// priced alternative; periodic exploration can recover when conditions change.
package struct DFlashVerifyBudget {
    package init() {}
    // Splash stores its public prior, labels, fitted coefficients and GPU
    // selection inputs as Float. The Newton fit itself remains Double.
    private static let prior = [Float(0.7), 0, -0.35, -0.8, -0.75, -0.75, -0.85, -0.45].map(Double.init)
    private var theta = Self.prior
    private struct Label { let position: Int; let feature: Double; let accepted: Bool }
    private var labels: [Label] = []
    private var next = 0, cycles = 0
    package var cycleCount: Int { cycles }
    package var labelCount: Int { labels.count }
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
    private func cost(_ rows: Int) -> Float {
        guard let (a, b) = fit else { return Float(Self.seed(rows)) }
        return Float(max(a + b * Double(rows), 0.05 * time / weight))
    }
    package func depth(confidence: [Float]) -> Int {
        precondition((1...7).contains(confidence.count))
        if cycles % 32 == 31 { return confidence.count }
        var survival: Float = 1, expected: Float = 1
        var best = 1 / cost(1), depth = 0
        for (position, value) in confidence.enumerated() {
            guard value.isFinite else { break }
            let probability = min(Float(1) - 1e-6, max(1e-6, value))
            let z = Float(theta[0]) * log(probability / (1 - probability)) + Float(theta[position + 1])
            survival *= 1 / (1 + exp(-z)); expected += survival
            let score = expected / cost(position + 2)
            if score > best { best = score; depth = position + 1 }
        }
        return depth
    }
    package mutating func observe(confidence: [Float], verified: Int, accepted: Int,
                                  seconds: Double, labelsValid: Bool = true, bonusAccepted: Bool? = nil) {
        guard (0...7).contains(verified), verified <= confidence.count,
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
            // An r-row target pass evaluates r predictions, including its
            // final bonus token. The caller may compare that prediction with
            // the next draft guess without consuming or retaining its state.
            // No observation means no label, preserving cancellation and the
            // target-only API's existing truncated-observation contract.
            let bonus = accepted == verified && verified < confidence.count ? bonusAccepted : nil
            let count = min(verified, accepted + 1) + (bonus == nil ? 0 : 1)
            for position in 0..<count {
                let p = confidence[position]
                guard p.isFinite && (0...1).contains(p) else { continue }
                let label = Label(position: position, feature: Double(Float(Self.logit(Double(p)))),
                    accepted: position < accepted || (position == verified && bonus == true))
                if labels.count < 4096 { labels.append(label) }
                else { labels[next] = label; next = (next + 1) % 4096 }
            }
        }
        cycles += 1
        if cycles % 64 == 0 && !labels.isEmpty { refit() }
    }
    private var orderedLabels: [Label] {
        Array(labels[next...]) + Array(labels[..<next])
    }
    private func objective(_ parameters: [Double], labels: [Label]) -> Double {
        var result = 0.0
        for label in labels {
            let z = parameters[0] * label.feature + parameters[label.position + 1]
            let margin = label.accepted ? z : -z
            result += margin > 0 ? log1p(exp(-margin)) : -margin + log1p(exp(margin))
        }
        for i in 0..<8 { result += 0.5 * (i == 0 ? 50 : 4) * (parameters[i] - Self.prior[i]) * (parameters[i] - Self.prior[i]) }
        return result
    }
    private mutating func refit() {
        let labels = orderedLabels
        var current = objective(theta, labels: labels)
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
                let value = objective(candidate, labels: labels)
                if value.isFinite && value <= current {
                    largest = zip(candidate, theta).map { abs($0 - $1) }.max()!
                    theta = candidate; current = value; moved = true; break
                }
                scale *= 0.5
            }
            if !moved || largest < 1e-9 { break }
        }
        theta = theta.map { Double(Float($0)) }
    }
}
