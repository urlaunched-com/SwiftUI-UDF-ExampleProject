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
        .local(path: "./DesignSystem"),
        .local(path: "./Localizations"),
        .remote(url: "https://github.com/Maks-Jago/SwiftUIKit", requirement: .upToNextMajor(from: "0.4.0")),
    ],
    settings: settings,
    appSettings: appSettings,
    targetDependancies: [
        .external(name: "FlagKit"),
        .external(name: "SDWebImageSwiftUI"),
        .external(name: "UDF"),
        .external(name: "SwiftFoundation"),
        .package(product: "SwiftUI-Kit"),
        .package(product: "DesignSystem"),
        .package(product: "Localizations"),
        .target(name: "Models"),
        .target(name: "Common"),
        .target(name: "API"),
    ],
    moduleTargets: [
        makeAllCoreModules(),
        makeAllFeatures()
    ].flatMap { $0 }
)

func makeAllCoreModules() -> [Module] {
    return [
        makeCommanModule(),
        makeModelsModule(),
        makeAPIModule(),
    ]
}

func makeAllFeatures() -> [Module] {
    return []
}

func makeModelsModule() -> Module {
    Module(
        name: "Models",
        moduleType: .core,
        path: "Models",
        frameworkDependancies: [
            .external(name: "SwiftFoundation"),
            .external(name: "UDF"),
            .package(product: "DesignSystem"),
            .target(name: "Common"),
            .target(name: "API"),
        ],
        frameworkResources: []
    )
}

func makeCommanModule() -> Module {
    return Module(
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
}

func makeAPIModule() -> Module {
    return Module(
        name: "API",
        moduleType: .core,
        path: "API",
        frameworkDependancies: [
            .external(name: "SwiftFoundation"),
        ],
        frameworkResources: []
    )
}
