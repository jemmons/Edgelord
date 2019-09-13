// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "Edgelord",
    products: [
        .library(name: "Edgelord", targets: ["Edgelord"]),
    ],
    targets: [
        .target(
            name: "Edgelord",
            dependencies: []),
        .testTarget(
            name: "EdgelordTests",
            dependencies: ["Edgelord"]),
    ]
)