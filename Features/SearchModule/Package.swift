// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "SearchModule",
    platforms: [
        .iOS(.v17),
    ],
    products: [
        .library(name: "SearchModule", targets: ["SearchModule"]),
    ],
    dependencies: [
        .package(path: "../../Core/Common"),
        .package(path: "../../Core/CustomViews"),
        .package(path: "../../Core/DesignSystem"),
        .package(path: "../../Core/Localizations"),
        .package(path: "../../Core/Models"),
        .package(url: "https://github.com/Maks-Jago/SwiftFoundation", from: "0.4.1"),
        .package(url: "https://github.com/Maks-Jago/SwiftUI-UDF", branch: "feature/research-and-implement-navigablefeaturestate-guid_869fkx6bg"),
    ],
    targets: [
        .target(
            name: "SearchModule",
            dependencies: [
                .product(name: "Common", package: "Common"),
                .product(name: "CustomViews", package: "CustomViews"),
                .product(name: "DesignSystem", package: "DesignSystem"),
                .product(name: "Localizations", package: "Localizations"),
                .product(name: "Models", package: "Models"),
                .product(name: "SwiftFoundation", package: "SwiftFoundation"),
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
