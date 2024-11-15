// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "Navigate",
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
