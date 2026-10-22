// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "Localizations",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v17),
    ],
    products: [
        .library(name: "Localizations", targets: ["Localizations"]),
    ],
    dependencies: [
        .package(url: "https://github.com/mac-cain13/R.swift", from: "7.0.0"),
    ],
    targets: [
        .target(
            name: "Localizations",
            dependencies: [
                .product(name: "RswiftLibrary", package: "R.swift"),
            ],
            path: "Sources",
            resources: [
                .process("Resources"),
            ],
            swiftSettings: [
                .enableUpcomingFeature("MemberImportVisibility"),
            ],
            plugins: [
                .plugin(name: "RswiftGeneratePublicResources", package: "R.swift"),
            ]
        ),
    ],
    swiftLanguageModes: [.v5]
)
