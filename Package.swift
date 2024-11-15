// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "Navigate",
    platforms: [
        .iOS(.v16),
        .macOS(.v13),
        .tvOS(.v16),
        .watchOS(.v9),
        .visionOS(.v1)
    ],
    products: [
        .library(
            name: "Navigate",
            targets: ["Navigate"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/nicklockwood/SwiftFormat", from: "0.54.6")
    ],
    targets: [
        .target(
            name: "Navigate"
        ),
        .testTarget(
            name: "NavigateTests",
            dependencies: ["Navigate"]
        )
    ]
)
