// swift-tools-version:6.1.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MoodleCoreSwift",
    platforms: [
            .macOS(.v13),
            .iOS(.v16)
        ],
    products: [
        .library(
            name: "MoodleCoreSwift",
            targets: ["MoodleCoreSwift"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "MoodleCoreSwift",
            dependencies: []),
        .testTarget(
            name: "MoodleCoreSwiftTests",
            dependencies: ["MoodleCoreSwift"],
            resources: [.process("HTML")]
        ),
    ]
)
