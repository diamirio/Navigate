// swift-tools-version: 6.1

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
    dependencies: [],
    targets: [
        .target(
            name: "Navigate",
            exclude: ["../../NavigateTesting"]
        ),
        .testTarget(
            name: "NavigateTests",
            dependencies: ["Navigate"],
            exclude: ["../../NavigateTesting"]
        )
    ]
)
