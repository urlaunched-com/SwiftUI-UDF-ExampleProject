// swift-tools-version: 5.9
import PackageDescription

#if TUIST
    import ProjectDescription

    let packageSettings = PackageSettings(
        productTypes: [
            "FlagKit": .framework,
            "SDWebImageSwiftUI": .framework,
            "SDWebImage": .framework,
            "UDF": .framework,
            "SwiftFoundation": .framework,
            "SwiftUI-Kit": .framework,
            "SwiftUISnapshotTestCase": .staticFramework,
        ]
    )
#endif // TUIST

let package = Package(
    name: "Flick",
    dependencies: [
        .package(url: "https://github.com/madebybowtie/FlagKit", .upToNextMajor(from: "2.0.0")),
        .package(url: "https://github.com/SDWebImage/SDWebImageSwiftUI", .upToNextMajor(from: "3.1.3")),
        .package(url: "https://github.com/Maks-Jago/swiftui-snapshot-test-case", .upToNextMajor(from: "1.7.3")),
        .package(url: "https://github.com/Maks-Jago/SwiftUI-UDF", exact: "2.0.0-alpha.4"),
        .package(url: "https://github.com/urlaunched-com/UDFMacros", exact: "0.3.0"),
        .package(url: "https://github.com/Maks-Jago/SwiftFoundation", .upToNextMajor(from: "0.4.1")),
        .package(url: "https://github.com/Maks-Jago/SwiftUIKit", .upToNextMajor(from: "0.6.5")),
    ]
)
