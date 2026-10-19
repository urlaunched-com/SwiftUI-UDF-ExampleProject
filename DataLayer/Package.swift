// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "DataLayer",
    platforms: [
        .iOS(.v17),
    ],
    products: [
        .library(name: "DataLayer", targets: ["DataLayer"]),
    ],
    dependencies: [
        .package(path: "../Core/API"),
        .package(path: "../Core/Common"),
        .package(path: "../Core/Models"),
        .package(path: "../Features/HomeModule"),
        .package(path: "../Features/ImageModule"),
        .package(path: "../Features/ItemDetailsModule"),
        .package(path: "../Features/MyFavoritesModule"),
        .package(path: "../Features/ReviewsModule"),
        .package(path: "../Features/SearchModule"),
    ],
    targets: [
        .target(
            name: "DataLayer",
            dependencies: [
                .product(name: "API", package: "API"),
                .product(name: "Common", package: "Common"),
                .product(name: "HomeModule", package: "HomeModule"),
                .product(name: "ImageModule", package: "ImageModule"),
                .product(name: "ItemDetailsModule", package: "ItemDetailsModule"),
                .product(name: "Models", package: "Models"),
                .product(name: "MyFavoritesModule", package: "MyFavoritesModule"),
                .product(name: "ReviewsModule", package: "ReviewsModule"),
                .product(name: "SearchModule", package: "SearchModule"),
            ],
            path: "Sources",
            swiftSettings: [
                .enableUpcomingFeature("MemberImportVisibility"),
            ]
        ),
    ],
    swiftLanguageModes: [.v5]
)
