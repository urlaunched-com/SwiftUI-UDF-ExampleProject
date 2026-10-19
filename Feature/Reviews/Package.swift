// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "Reviews",
    platforms: [
        .iOS(.v17),
    ],
    products: [
        .library(name: "Reviews", targets: ["Reviews"]),
    ],
    dependencies: [
        .package(path: "../../Core/Common"),
        .package(path: "../../Core/CustomViews"),
        .package(path: "../../Core/DesignSystem"),
        .package(path: "../../Core/Localizations"),
        .package(path: "../../Core/Models"),
        .package(url: "https://github.com/Maks-Jago/SwiftUI-UDF", branch: "2.0.0"),
    ],
    targets: [
        .target(
            name: "Reviews",
            dependencies: [
                .product(name: "Common", package: "Common"),
                .product(name: "CustomViews", package: "CustomViews"),
                .product(name: "DesignSystem", package: "DesignSystem"),
                .product(name: "Localizations", package: "Localizations"),
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
