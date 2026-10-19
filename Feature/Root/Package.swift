// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "Root",
    platforms: [
        .iOS(.v17),
    ],
    products: [
        .library(name: "Root", targets: ["Root"]),
    ],
    dependencies: [
        .package(path: "../../Core/Common"),
        .package(path: "../../Core/DesignSystem"),
        .package(url: "https://github.com/Maks-Jago/SwiftFoundation", from: "0.4.1"),
        .package(url: "https://github.com/Maks-Jago/SwiftUI-UDF", branch: "2.0.0"),
        .package(url: "https://github.com/Maks-Jago/SwiftUIKit", from: "0.6.5"),
    ],
    targets: [
        .target(
            name: "Root",
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
