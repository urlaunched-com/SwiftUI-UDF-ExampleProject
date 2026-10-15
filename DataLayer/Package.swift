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
        .package(path: "../Core/Models"),
        .package(path: "../Feature/Home"),
        .package(path: "../Feature/Image"),
        .package(path: "../Feature/ItemDetails"),
        .package(path: "../Feature/MyFavorites"),
        .package(path: "../Feature/Reviews"),
        .package(path: "../Feature/Search"),
    ],
    targets: [
        .target(
            name: "DataLayer",
            dependencies: [
                .product(name: "API", package: "API"),
                .product(name: "Home", package: "Home"),
                .product(name: "Image", package: "Image"),
                .product(name: "ItemDetails", package: "ItemDetails"),
                .product(name: "Models", package: "Models"),
                .product(name: "MyFavorites", package: "MyFavorites"),
                .product(name: "Reviews", package: "Reviews"),
                .product(name: "Search", package: "Search"),
            ],
            path: "Sources"
        ),
    ],
    swiftLanguageModes: [.v5]
)
