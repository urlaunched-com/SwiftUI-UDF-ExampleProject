import ProjectDescription

let project = Project(
    name: "Flick",
    packages: [
        .local(path: "./API"),
        .local(path: "./DesignSystem"),
        .local(path: "./Localizations"),
        .remote(url: "https://github.com/Maks-Jago/SwiftFoundation.git", requirement: .upToNextMajor(from: "0.3.6")),
        .remote(url: "https://github.com/Maks-Jago/SwiftUIKit", requirement: .upToNextMajor(from: "0.4.0")),
    ],
    settings: .settings(
        base: [
            "OTHER_LDFLAGS": ["$(inherited)", "-ObjC"],
        ],
        configurations: [
            .debug(name: "Debug", xcconfig: "./xcconfigs/Flick-Project.xcconfig"),
            .release(name: "Release", xcconfig: "./xcconfigs/Flick-Project.xcconfig"),
        ]
    ),
    targets: [
        .target(
            name: "Flick",
            destinations: .iOS,
            product: .app,
            bundleId: "com.urlaunched.flick",
            infoPlist: .file(path: "./Info.plist"),
            sources: ["Flick/Sources/**"],
            resources: ["Flick/Resources/**"],
            dependencies: [
                .external(name: "FlagKit", condition: nil),
                .external(name: "SDWebImageSwiftUI", condition: nil),
                .external(name: "UDF", condition: nil),
                .package(product: "SwiftUI-Kit"),
                .package(product: "SwiftFoundation"),
                .package(product: "API"),
                .package(product: "DesignSystem"),
                .package(product: "Localizations"),
            ],
            settings: .settings(
                configurations: [
                    .debug(name: "Debug", xcconfig: "./xcconfigs/Flick.xcconfig"),
                    .release(name: "Release", xcconfig: "./xcconfigs/Flick.xcconfig"),
                ])
        ),
    ]
)
