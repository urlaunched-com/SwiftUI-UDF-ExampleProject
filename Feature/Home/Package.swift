// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "Home",
    platforms: [
        .iOS(.v17),
    ],
    products: [
        .library(name: "Home", targets: ["Home"]),
    ],
    dependencies: [
        .package(path: "../../Core/Common"),
        .package(path: "../../Core/CustomViews"),
        .package(path: "../../Core/DesignSystem"),
        .package(path: "../../Core/Localizations"),
        .package(path: "../../Core/Models"),
        .package(url: "https://github.com/Maks-Jago/SwiftUI-UDF", branch: "2.0.0"),
        .package(url: "https://github.com/Maks-Jago/SwiftUIKit", from: "0.6.5"),
        .package(url: "https://github.com/urlaunched-com/UDFMacros", from: "0.3.0"),
    ],
    targets: [
        .target(
            name: "Home",
            dependencies: [
                .product(name: "Common", package: "Common"),
                .product(name: "CustomViews", package: "CustomViews"),
                .product(name: "DesignSystem", package: "DesignSystem"),
                .product(name: "Localizations", package: "Localizations"),
                .product(name: "Models", package: "Models"),
                .product(name: "SwiftUI-Kit", package: "SwiftUIKit"),
                .product(name: "UDF", package: "SwiftUI-UDF"),
                .product(name: "UDFMacros", package: "UDFMacros"),
            ],
            path: "Sources",
            swiftSettings: [
                .enableUpcomingFeature("MemberImportVisibility"),
            ]
        ),
    ],
    swiftLanguageModes: [.v5]
)
