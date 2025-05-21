// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Localizations",
    defaultLocalization: "en",
    products: [
        .library(
            name: "Localizations",
            targets: ["Localizations"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/mac-cain13/R.swift.git", from: "7.0.0"),
    ],
    targets: [
        .target(
            name: "Localizations",
            dependencies: [.product(name: "RswiftLibrary", package: "R.swift")],
            resources: [
                .process("Resources"),
            ],
            plugins: [
                .plugin(name: "RswiftGeneratePublicResources", package: "R.swift"),
            ]
        ),
    ]
)
