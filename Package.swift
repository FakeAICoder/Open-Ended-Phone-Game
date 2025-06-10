// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "OpenEndedPhoneGame",
    platforms: [
        .iOS(.v17),
        .macOS(.v13)
    ],
    products: [
        .executable(
            name: "OpenEndedPhoneGame",
            targets: ["OpenEndedPhoneGame"])
    ],
    targets: [
        .executableTarget(
            name: "OpenEndedPhoneGame",
            path: "Sources/OpenEndedPhoneGame"),
        .testTarget(
            name: "OpenEndedPhoneGameTests",
            dependencies: ["OpenEndedPhoneGame"],
            path: "Tests/OpenEndedPhoneGameTests"),
    ]
)
