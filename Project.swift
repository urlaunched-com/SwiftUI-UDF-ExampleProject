import ProjectDescription
import ProjectDescriptionHelpers

let settings: Settings = .settings(
    base: [
        "OTHER_LDFLAGS": ["$(inherited)", "-ObjC"],
    ],
    configurations: [
        .debug(name: "Debug", xcconfig: "./xcconfigs/Flick-Project.xcconfig"),
        .release(name: "Release", xcconfig: "./xcconfigs/Flick-Project.xcconfig"),
    ]
)


let appSettings: Settings = .settings(
    configurations: [
        .debug(name: "Debug", xcconfig: "./xcconfigs/Flick.xcconfig"),
        .release(name: "Release", xcconfig: "./xcconfigs/Flick.xcconfig"),
    ]
)

let project = Project.app(
    name: "Flick",
    organizationName: "urlaunched",
    packages: [
        .local(path: "./API"),
        .local(path: "./DesignSystem"),
        .local(path: "./Localizations"),
        .remote(url: "https://github.com/Maks-Jago/SwiftFoundation.git", requirement: .upToNextMajor(from: "0.3.6")),
        .remote(url: "https://github.com/Maks-Jago/SwiftUIKit", requirement: .upToNextMajor(from: "0.4.0")),
    ],
    settings: settings,
    appSettings: appSettings,
    targetDependancies: [
        .external(name: "FlagKit"),
        .external(name: "SDWebImageSwiftUI"),
        .external(name: "UDF"),
        .package(product: "SwiftUI-Kit"),
        .package(product: "SwiftFoundation"),
        .package(product: "API"),
        .package(product: "DesignSystem"),
        .package(product: "Localizations"),
    ],
    moduleTargets: [
        Module(
            name: "Models",
            moduleType: .core,
            path: "Models",
            frameworkDependancies: [
                .package(product: "SwiftFoundation"),
                .external(name: "UDF"),
                .package(product: "API"),
                .package(product: "DesignSystem"),
                .target(name: "Common"),
            ],
            frameworkResources: []
        ),
        Module(
            name: "Common",
            moduleType: .core,
            path: "Common",
            frameworkDependancies: [
                .external(name: "UDF"),
                .package(product: "SwiftUI-Kit"),
                .package(product: "DesignSystem"),
            ],
            frameworkResources: []
        )
    ]
)
