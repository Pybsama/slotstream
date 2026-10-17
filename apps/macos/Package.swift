// swift-tools-version: 6.0
import PackageDescription

// This package is Mac-owned. The root package remains Slotstream's independent
// public embedding and command-line surface.
let package = Package(
    name: "SlotstreamMac",
    platforms: [.macOS(.v14)],
    products: [
        .library(name: "SlotstreamRuntime", targets: ["SlotstreamRuntime"]),
        .library(name: "SlotstreamPresentation", targets: ["SlotstreamPresentation"]),
        // Xcode gives package products a workspace-wide identity. Keep this
        // internal product distinct from the public Slotstream engine library.
        .executable(name: "SlotstreamDesktop", targets: ["SlotstreamMac"]),
        .executable(name: "slotstream-presentation-checks", targets: ["SlotstreamPresentationChecks"]),
        .executable(name: "slotstream-composer-checks", targets: ["SlotstreamComposerChecks"]),
        .executable(name: "slotstream-local", targets: ["SlotstreamLocal"]),
        .executable(name: "slotstream-mac-checks", targets: ["SlotstreamMacChecks"]),
        .executable(name: "slotstream-extract", targets: ["SlotstreamExtract"]),
    ],
    dependencies: [.package(path: "../.."), .package(url: "https://github.com/swiftlang/swift-markdown.git", exact: "0.8.0")],
    targets: [
        .target(name: "SlotstreamText", dependencies: [.product(name: "Markdown", package: "swift-markdown")], path: "Text", swiftSettings: [.swiftLanguageMode(.v5)]),
        .target(name: "SlotstreamPresentation", dependencies: ["SlotstreamText", .product(name: "Markdown", package: "swift-markdown")], path: "Presentation", swiftSettings: [.swiftLanguageMode(.v5)]),
        .executableTarget(name: "SlotstreamPresentationChecks", dependencies: ["SlotstreamPresentation"], path: "PresentationTests", swiftSettings: [.swiftLanguageMode(.v5)]),
        .executableTarget(name: "SlotstreamComposerChecks", dependencies: ["SlotstreamPresentation", "SlotstreamRuntime"], path: "ComposerChecks", swiftSettings: [.swiftLanguageMode(.v5)]),
        .target(name: "SlotstreamRuntime", dependencies: ["SlotstreamText", .product(name: "Slotstream", package: "slotstream")], path: "Runtime", swiftSettings: [.swiftLanguageMode(.v5)]),
        .executableTarget(name: "SlotstreamMac", dependencies: ["SlotstreamRuntime", "SlotstreamPresentation"], path: "App", swiftSettings: [.swiftLanguageMode(.v5)]),
        .executableTarget(name: "SlotstreamLocal", dependencies: ["SlotstreamRuntime"], path: "CLI", swiftSettings: [.swiftLanguageMode(.v5)]),
        .executableTarget(name: "SlotstreamMacChecks", dependencies: ["SlotstreamRuntime"], path: "Checks", swiftSettings: [.swiftLanguageMode(.v5)]),
        // The untrusted-document reader. It depends on nothing else in Slotstream
        // so the smallest possible code runs inside its sandbox.
        .target(name: "CSlotstreamSandbox", path: "CSandbox"),
        .executableTarget(name: "SlotstreamExtract", dependencies: ["CSlotstreamSandbox"], path: "Extract", swiftSettings: [.swiftLanguageMode(.v5)]),
    ]
)
