// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "Navigate",
    platforms: [
        .iOS(.v16),
        .macOS(.v13),
        .tvOS(.v16),
        .watchOS(.v9)
    ],
    products: [
        .library(
            name: "Navigate",
            targets: ["Navigate"]
        ),
    ],
    targets: [
        .target(
            name: "Navigate"
        ),
        .testTarget(
            name: "NavigateTests",
            dependencies: ["Navigate"]
        ),
    ]
)
