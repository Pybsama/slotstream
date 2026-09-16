import AppKit
import SwiftUI

/// Build artwork, not a running app. Reuses the exact native Observer geometry.
/// The transparent margin and rounded warm tile belong to the Mac icon only.
@main struct RenderSevraIcon {
    @MainActor static func main() throws {
        guard CommandLine.arguments.count == 2 else {
            throw NSError(domain: "SevraIcon", code: 1, userInfo: [NSLocalizedDescriptionKey: "Pass an output .iconset directory."])
        }
        let directory = URL(fileURLWithPath: CommandLine.arguments[1], isDirectory: true)
        try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true)
        for points in [16, 32, 128, 256, 512] {
            for scale in [1, 2] {
                let pixels = points * scale
                let renderer = ImageRenderer(content:
                    ZStack {
                        RoundedRectangle(cornerRadius: 180, style: .continuous)
                            .fill(Color(red: 244/255, green: 243/255, blue: 238/255))
                            .frame(width: 824, height: 824)
                        ObserverMark().fill(Color(red: 20/255, green: 20/255, blue: 20/255))
                            .frame(width: 740, height: 740)
                    }.frame(width: 1024, height: 1024)
                )
                renderer.scale = CGFloat(pixels) / 1024
                guard let cg = renderer.cgImage,
                      let data = NSBitmapImageRep(cgImage: cg).representation(using: .png, properties: [:]) else {
                    throw NSError(domain: "SevraIcon", code: 2, userInfo: [NSLocalizedDescriptionKey: "Could not render Observer."])
                }
                let suffix = scale == 2 ? "@2x" : ""
                try data.write(to: directory.appendingPathComponent("icon_\(points)x\(points)\(suffix).png"))
            }
        }
    }
}
