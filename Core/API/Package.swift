// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "API",
    platforms: [
        .iOS(.v17),
    ],
    products: [
        .library(name: "API", targets: ["API"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Maks-Jago/SwiftFoundation", from: "0.4.1"),
    ],
    targets: [
        .target(
            name: "API",
            dependencies: [
                .product(name: "SwiftFoundation", package: "SwiftFoundation"),
            ],
            path: "Sources"
        ),
    ],
    swiftLanguageModes: [.v5]
)
