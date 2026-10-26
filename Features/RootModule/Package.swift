// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "RootModule",
    platforms: [
        .iOS(.v17),
    ],
    products: [
        .library(name: "RootModule", targets: ["RootModule"]),
    ],
    dependencies: [
        .package(path: "../../Core/Common"),
        .package(path: "../../Core/DesignSystem"),
        .package(url: "https://github.com/Maks-Jago/SwiftFoundation", from: "0.4.1"),
        .package(url: "https://github.com/Maks-Jago/SwiftUI-UDF", branch: "feature/research-and-implement-navigablefeaturestate-guid_869fkx6bg"),
        .package(url: "https://github.com/Maks-Jago/SwiftUIKit", from: "0.6.5"),
    ],
    targets: [
        .target(
            name: "RootModule",
            dependencies: [
                .product(name: "Common", package: "Common"),
                .product(name: "DesignSystem", package: "DesignSystem"),
                .product(name: "SwiftFoundation", package: "SwiftFoundation"),
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
