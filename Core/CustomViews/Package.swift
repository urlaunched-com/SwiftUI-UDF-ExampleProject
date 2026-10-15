// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "CustomViews",
    platforms: [
        .iOS(.v17),
    ],
    products: [
        .library(name: "CustomViews", targets: ["CustomViews"]),
    ],
    dependencies: [
        .package(path: "../Common"),
        .package(path: "../DesignSystem"),
        .package(path: "../Localizations"),
        .package(path: "../Models"),
        .package(url: "https://github.com/Maks-Jago/SwiftUI-UDF", branch: "2.0.0"),
        .package(url: "https://github.com/Maks-Jago/SwiftUIKit", from: "0.6.5"),
        .package(url: "https://github.com/SDWebImage/SDWebImageSwiftUI", from: "3.1.3"),
    ],
    targets: [
        .target(
            name: "CustomViews",
            dependencies: [
                .product(name: "Common", package: "Common"),
                .product(name: "DesignSystem", package: "DesignSystem"),
                .product(name: "Localizations", package: "Localizations"),
                .product(name: "Models", package: "Models"),
                .product(name: "SDWebImageSwiftUI", package: "SDWebImageSwiftUI"),
                .product(name: "SwiftUI-Kit", package: "SwiftUIKit"),
                .product(name: "UDF", package: "SwiftUI-UDF"),
            ],
            path: "Sources"
        ),
    ],
    swiftLanguageModes: [.v5]
)
