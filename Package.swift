// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "SkyDash",
    products: [
        .executable(name: "skydash", targets: ["SkyDash"]),
    ],
    targets: [
        .executableTarget(
            name: "SkyDash",
            path: "SkyDash/Sources"
        )
    ]
)
