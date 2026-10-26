// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "Common",
    platforms: [
        .iOS(.v17),
    ],
    products: [
        .library(name: "Common", targets: ["Common"]),
    ],
    dependencies: [
        .package(path: "../DesignSystem"),
        .package(url: "https://github.com/Maks-Jago/SwiftUI-UDF", branch: "feature/research-and-implement-navigablefeaturestate-guid_869fkx6bg"),
        .package(url: "https://github.com/Maks-Jago/SwiftUIKit", from: "0.6.5"),
    ],
    targets: [
        .target(
            name: "Common",
            dependencies: [
                .product(name: "DesignSystem", package: "DesignSystem"),
                .product(name: "SwiftUI-Kit", package: "SwiftUIKit"),
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
