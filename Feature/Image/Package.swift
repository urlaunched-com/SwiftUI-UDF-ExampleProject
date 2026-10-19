// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "Image",
    platforms: [
        .iOS(.v17),
    ],
    products: [
        .library(name: "Image", targets: ["Image"]),
    ],
    dependencies: [
        .package(path: "../../Core/Common"),
        .package(path: "../../Core/DesignSystem"),
        .package(path: "../../Core/Models"),
        .package(url: "https://github.com/Maks-Jago/SwiftUI-UDF", branch: "2.0.0"),
        .package(url: "https://github.com/Maks-Jago/SwiftUIKit", from: "0.6.5"),
        .package(url: "https://github.com/SDWebImage/SDWebImageSwiftUI", from: "3.1.3"),
    ],
    targets: [
        .target(
            name: "Image",
            dependencies: [
                .product(name: "Common", package: "Common"),
                .product(name: "DesignSystem", package: "DesignSystem"),
                .product(name: "Models", package: "Models"),
                .product(name: "SDWebImageSwiftUI", package: "SDWebImageSwiftUI"),
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
