// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "Auth",
    platforms: [
        .iOS(.v17),
    ],
    products: [
        .library(name: "Auth", targets: ["Auth"]),
    ],
    dependencies: [
        .package(path: "../../Core/Common"),
        .package(path: "../../Core/DesignSystem"),
        .package(path: "../../Core/Localizations"),
        .package(url: "https://github.com/Maks-Jago/SwiftFoundation", from: "0.4.1"),
        .package(url: "https://github.com/Maks-Jago/SwiftUI-UDF", branch: "2.0.0"),
    ],
    targets: [
        .target(
            name: "Auth",
            dependencies: [
                .product(name: "Common", package: "Common"),
                .product(name: "DesignSystem", package: "DesignSystem"),
                .product(name: "Localizations", package: "Localizations"),
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
