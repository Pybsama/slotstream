// swift-tools-version: 6.0
import PackageDescription

// This package is Mac-owned. The root package remains Slotstream's independent
// public embedding and command-line surface.
let package = Package(
    name: "SevraMac",
    platforms: [.macOS(.v14)],
    products: [
        .library(name: "SevraRuntime", targets: ["SevraRuntime"]),
        .library(name: "SevraPresentation", targets: ["SevraPresentation"]),
        .executable(name: "Sevra", targets: ["SevraMac"]),
        .executable(name: "sevra-presentation-checks", targets: ["SevraPresentationChecks"]),
        .executable(name: "sevra-composer-checks", targets: ["SevraComposerChecks"]),
        .executable(name: "sevra-local", targets: ["SevraLocal"]),
        .executable(name: "sevra-mac-checks", targets: ["SevraMacChecks"]),
    ],
    dependencies: [.package(path: "../.."), .package(url: "https://github.com/swiftlang/swift-markdown.git", exact: "0.8.0")],
    targets: [
        .target(name: "SevraPresentation", dependencies: [.product(name: "Markdown", package: "swift-markdown")], path: "Presentation", swiftSettings: [.swiftLanguageMode(.v5)]),
        .executableTarget(name: "SevraPresentationChecks", dependencies: ["SevraPresentation"], path: "PresentationTests", swiftSettings: [.swiftLanguageMode(.v5)]),
        .executableTarget(name: "SevraComposerChecks", dependencies: ["SevraPresentation", "SevraRuntime"], path: "ComposerChecks", swiftSettings: [.swiftLanguageMode(.v5)]),
        .target(name: "SevraRuntime", dependencies: [.product(name: "Slotstream", package: "slotstream")], path: "Runtime", swiftSettings: [.swiftLanguageMode(.v5)]),
        .executableTarget(name: "SevraMac", dependencies: ["SevraRuntime", "SevraPresentation"], path: "App", swiftSettings: [.swiftLanguageMode(.v5)]),
        .executableTarget(name: "SevraLocal", dependencies: ["SevraRuntime"], path: "CLI", swiftSettings: [.swiftLanguageMode(.v5)]),
        .executableTarget(name: "SevraMacChecks", dependencies: ["SevraRuntime"], path: "Checks", swiftSettings: [.swiftLanguageMode(.v5)]),
    ]
)
