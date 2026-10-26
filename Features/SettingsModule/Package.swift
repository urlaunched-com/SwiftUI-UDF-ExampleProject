// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "SettingsModule",
    platforms: [
        .iOS(.v17),
    ],
    products: [
        .library(name: "SettingsModule", targets: ["SettingsModule"]),
    ],
    dependencies: [
        .package(path: "../../Core/Common"),
        .package(path: "../../Core/DesignSystem"),
        .package(path: "../../Core/Localizations"),
        .package(url: "https://github.com/Maks-Jago/SwiftUI-UDF", branch: "feature/research-and-implement-navigablefeaturestate-guid_869fkx6bg"),
        .package(url: "https://github.com/Maks-Jago/SwiftUIKit", from: "0.6.5"),
    ],
    targets: [
        .target(
            name: "SettingsModule",
            dependencies: [
                .product(name: "Common", package: "Common"),
                .product(name: "DesignSystem", package: "DesignSystem"),
                .product(name: "Localizations", package: "Localizations"),
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
