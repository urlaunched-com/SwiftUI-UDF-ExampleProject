// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "NetworkConnectivity",
    platforms: [
        .iOS(.v17),
    ],
    products: [
        .library(name: "NetworkConnectivity", targets: ["NetworkConnectivity"]),
    ],
    dependencies: [
        .package(path: "../../Core/Common"),
        .package(path: "../../Core/Models"),
        .package(url: "https://github.com/Maks-Jago/SwiftUI-UDF", branch: "2.0.0"),
    ],
    targets: [
        .target(
            name: "NetworkConnectivity",
            dependencies: [
                .product(name: "Common", package: "Common"),
                .product(name: "Models", package: "Models"),
                .product(name: "UDF", package: "SwiftUI-UDF"),
            ],
            path: "Sources",
            swiftSettings: [
                .enableUpcomingFeature("MemberImportVisibility"),
            ]
        ),
    ],
    swiftLanguageModes: [.v5]
)
