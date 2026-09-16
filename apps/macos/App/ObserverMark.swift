import SwiftUI

/// Native path transcription of the approved Observer mark, preserving the
/// production SVG's geometry (66c4c382…e0ef3b). Color follows app appearance.
struct ObserverMark: Shape {
    func path(in rect: CGRect) -> Path {
        var p = Path()
        p.move(to: CGPoint(x: 33, y: 5))
        p.addCurve(to: CGPoint(x: 33, y: 19), control1: CGPoint(x: 30, y: 3), control2: CGPoint(x: 32, y: 15))
        p.addCurve(to: CGPoint(x: 39, y: 28), control1: CGPoint(x: 34, y: 23), control2: CGPoint(x: 36, y: 26))
        p.addLine(to: CGPoint(x: 46, y: 24))
        p.addCurve(to: CGPoint(x: 33, y: 5), control1: CGPoint(x: 44, y: 16), control2: CGPoint(x: 39, y: 8)); p.closeSubpath()
        p.move(to: CGPoint(x: 49, y: 1))
        p.addCurve(to: CGPoint(x: 48, y: 16), control1: CGPoint(x: 46, y: -1), control2: CGPoint(x: 47, y: 11))
        p.addCurve(to: CGPoint(x: 60, y: 25), control1: CGPoint(x: 50, y: 21), control2: CGPoint(x: 54, y: 24))
        p.addCurve(to: CGPoint(x: 49, y: 1), control1: CGPoint(x: 61, y: 15), control2: CGPoint(x: 57, y: 6)); p.closeSubpath()
        p.move(to: CGPoint(x: 38, y: 25)); p.addLine(to: CGPoint(x: 8, y: 49))
        p.addCurve(to: CGPoint(x: 1, y: 60), control1: CGPoint(x: 3, y: 52), control2: CGPoint(x: 1, y: 54))
        p.addLine(to: CGPoint(x: 1, y: 66))
        p.addCurve(to: CGPoint(x: 10, y: 74), control1: CGPoint(x: 1, y: 72), control2: CGPoint(x: 4, y: 74))
        p.addLine(to: CGPoint(x: 29, y: 74))
        p.addCurve(to: CGPoint(x: 47, y: 91), control1: CGPoint(x: 41, y: 74), control2: CGPoint(x: 46, y: 81))
        for point in [CGPoint(x: 48, y: 100), CGPoint(x: 52, y: 100), CGPoint(x: 51, y: 90)] { p.addLine(to: point) }
        p.addCurve(to: CGPoint(x: 29, y: 70), control1: CGPoint(x: 49, y: 76), control2: CGPoint(x: 43, y: 70))
        for point in [CGPoint(x: 18, y: 70), CGPoint(x: 16, y: 51), CGPoint(x: 41, y: 29)] { p.addLine(to: point) }; p.closeSubpath()
        p.move(to: CGPoint(x: 66, y: 11))
        p.addCurve(to: CGPoint(x: 99, y: 51), control1: CGPoint(x: 87, y: 14), control2: CGPoint(x: 99, y: 29))
        for point in [CGPoint(x: 100, y: 100), CGPoint(x: 88, y: 100), CGPoint(x: 98, y: 90), CGPoint(x: 98, y: 81), CGPoint(x: 77, y: 100), CGPoint(x: 62, y: 100), CGPoint(x: 93, y: 73), CGPoint(x: 91, y: 62), CGPoint(x: 56, y: 91)] { p.addLine(to: point) }
        p.addCurve(to: CGPoint(x: 55, y: 89), control1: CGPoint(x: 54, y: 93), control2: CGPoint(x: 54, y: 91))
        for point in [CGPoint(x: 86, y: 45), CGPoint(x: 81, y: 38), CGPoint(x: 56, y: 66)] { p.addLine(to: point) }
        p.addCurve(to: CGPoint(x: 55, y: 63), control1: CGPoint(x: 54, y: 68), control2: CGPoint(x: 54, y: 66))
        p.addLine(to: CGPoint(x: 72, y: 29)); p.closeSubpath()
        p.addEllipse(in: CGRect(x: 41.5, y: 38.5, width: 7, height: 7))
        let size = min(rect.width, rect.height)
        return p.applying(CGAffineTransform(a: 0.84, b: 0, c: 0, d: 0.84, tx: 8, ty: 8))
            .applying(CGAffineTransform(a: size / 100, b: 0, c: 0, d: size / 100, tx: rect.midX - size / 2, ty: rect.midY - size / 2))
    }
}
