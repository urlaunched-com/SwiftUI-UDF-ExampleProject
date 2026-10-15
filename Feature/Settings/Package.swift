// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "Settings",
    platforms: [
        .iOS(.v17),
    ],
    products: [
        .library(name: "Settings", targets: ["Settings"]),
    ],
    dependencies: [
        .package(path: "../../Core/Common"),
        .package(path: "../../Core/Localizations"),
        .package(url: "https://github.com/Maks-Jago/SwiftUI-UDF", branch: "2.0.0"),
        .package(url: "https://github.com/Maks-Jago/SwiftUIKit", from: "0.6.5"),
    ],
    targets: [
        .target(
            name: "Settings",
            dependencies: [
                .product(name: "Common", package: "Common"),
                .product(name: "Localizations", package: "Localizations"),
                .product(name: "SwiftUI-Kit", package: "SwiftUIKit"),
                .product(name: "UDF", package: "SwiftUI-UDF"),
            ],
            path: "Sources"
        ),
    ],
    swiftLanguageModes: [.v5]
)
