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

let snapshotCommonModelsUDFDependencies: [TargetDependency] = [
    .target(name: "Common"),
    .target(name: "Models"),
    .external(name: "UDF"),
]

let snapshotCommonUDFDependencies: [TargetDependency] = [
    .target(name: "Common"),
    .external(name: "UDF"),
]

let snapshotUDFDependencies: [TargetDependency] = [
    .external(name: "UDF"),
]

let project = Project.app(
    name: "Flick",
    organizationName: "urlaunched",
    packages: [
    ],
    settings: settings,
    appSettings: appSettings,
    targetDependancies: [
        .target(name: "API"),
        .target(name: "Cast"),
        .target(name: "CastSection"),
        .target(name: "Common"),
        .external(name: "FlagKit"),
        .target(name: "Home"),
        .target(name: "HomeSection"),
        .target(name: "Image"),
        .target(name: "ItemDetails"),
        .target(name: "Localizations"),
        .target(name: "MainHomeSection"),
        .target(name: "Models"),
        .target(name: "MyFavorites"),
        .target(name: "NetworkConnectivity"),
        .target(name: "Onboarding"),
        .target(name: "Recommendations"),
        .target(name: "RecommendationsSection"),
        .target(name: "ReviewDetails"),
        .target(name: "Reviews"),
        .target(name: "ReviewsSection"),
        .target(name: "Root"),
        .external(name: "SDWebImageSwiftUI"),
        .target(name: "Search"),
        .target(name: "SectionDetails"),
        .target(name: "Settings"),
        .target(name: "SignIn"),
        .external(name: "UDF"),
        .external(name: "SwiftFoundation"),
        .external(name: "SwiftUI-Kit"),
        .target(name: "TabBar"),
        .target(name: "WhereToWatch"),
    ],
    moduleTargets: [
        makeAllCoreModules(),
        makeUIModules()
    ].flatMap { $0 }
)

func makeAllCoreModules() -> [Module] {
    return [
        makeCommanModule(),
        makeModelsModule(),
        makeAPIModule(),
        makeDesignSystemModule(),
        makeLocalizationModule(),
        makeCustomViewsModule(),
    ]
}

func makeUIModules() -> [Module] {
    return [
        makeOnboardingFeature(),
        makeSignInFeature(),
        makeWhereToWatchFeature(),
        makeNetworkConnectivityFeature(),
        makeReviewDetailsFeature(),
        makeReviewsFeature(),
        makeReviewsSectionFeature(),
        makeSearchFeature(),
        makeMyFavoritesFeature(),
        makeSettingsFeature(),
        makeCastFeature(),
        makeCastSectionFeature(),
        makeImageFeature(),
        makeMainHomeSectionFeature(),
        makeHomeSectionFeature(),
        makeHomeFeature(),
        makeTabBarFeature(),
        makeRootFeature(),
        makeRecommendations(),
        makeRecommendationsSection(),
        makeSectionDetails(),
        makeItemDetailsFeature(),
    ]
}

func makeModelsModule() -> Module {
    Module(
        name: "Models",
        moduleType: .core,
        path: "Models",
        frameworkDependancies: [
            .external(name: "SwiftFoundation"),
            .external(name: "UDF"),
            .target(name: "DesignSystem"),
            .target(name: "Common"),
            .target(name: "API"),
            .target(name: "Localizations"),
            .external(name: "RswiftLibrary"),
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
            .external(name: "SwiftUI-Kit"),
            .target(name: "DesignSystem"),
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

func makeDesignSystemModule() -> Module {
    return Module(
        name: "DesignSystem",
        moduleType: .core,
        path: "DesignSystem",
        frameworkDependancies: [
            .external(name: "SwiftUI-Kit"),
        ],
        frameworkResources: [
            "Resources/**"
        ]
    )
}

func makeCustomViewsModule() -> Module {
    return Module(
        name: "CustomViews",
        moduleType: .core,
        path: "CustomViews",
        frameworkDependancies: [
            .external(name: "UDF"),
            .external(name: "SwiftUI-Kit"),
            .external(name: "SDWebImageSwiftUI"),
            .target(name: "Common"),
            .target(name: "DesignSystem"),
            .target(name: "Models"),
            .target(name: "Localizations"),
        ],
        frameworkResources: []
    )
}

func makeLocalizationModule() -> Module {
    return Module(
        name: "Localizations",
        moduleType: .core,
        path: "Localizations",
        frameworkDependancies: [
            .external(name: "RswiftLibrary")
        ],
        frameworkResources: [
            "Resources/**"
        ],
        frameworkScripts: [
            .pre(
                script: """
                "$PROJECT_DIR/Core/Localizations/rswift" generate --access-level public "$PROJECT_DIR/Core/Localizations/Sources/R.generated.swift"
                """,
                name: "R.swift"
            )
        ]
    )
}

func makeOnboardingFeature() -> Module {
    return Module(
        name: "Onboarding",
        moduleType: .feature,
        path: "Onboarding",
        frameworkDependancies: [
            .external(name: "UDF"),
            .external(name: "SwiftUI-Kit"),
            .target(name: "DesignSystem"),
            .target(name: "Localizations"),
            .external(name: "RswiftLibrary")
        ],
        frameworkResources: [],
        snapshotDependencies: snapshotUDFDependencies,
        snapshotHostAppDependencies: [
            .external(name: "UDF"),
            .external(name: "SwiftUI-Kit"),
            .external(name: "RswiftLibrary"),
        ],
        targets: [.framework, .snapshotTests]
    )
}

func makeSignInFeature() -> Module {
    return Module(
        name: "SignIn",
        moduleType: .feature,
        path: "SignIn",
        frameworkDependancies: [
            .external(name: "UDF"),
            .external(name: "SwiftFoundation"),
            .target(name: "DesignSystem"),
            .target(name: "Localizations"),
            .external(name: "RswiftLibrary"),
            .target(name: "Common"),
        ],
        frameworkResources: [],
        snapshotDependencies: snapshotCommonUDFDependencies,
        snapshotHostAppDependencies: [
            .external(name: "UDF"),
            .external(name: "SwiftFoundation"),
        ],
        targets: [.framework, .snapshotTests]
    )
}

func makeWhereToWatchFeature() -> Module {
    return Module(
        name: "WhereToWatch",
        moduleType: .feature,
        path: "WhereToWatch",
        frameworkDependancies: [
            .external(name: "UDF"),
            .target(name: "Localizations"),
            .external(name: "RswiftLibrary"),
            .target(name: "Common"),
            .target(name: "Models"),
            .external(name: "FlagKit"),
        ],
        frameworkResources: [],
        snapshotDependencies: [
            .target(name: "Common"),
            .target(name: "Models"),
            .external(name: "FlagKit"),
            .external(name: "UDF"),
        ],
        snapshotHostAppDependencies: [
            .external(name: "UDF"),
            .external(name: "RswiftLibrary"),
            .external(name: "FlagKit"),
        ],
        targets: [.framework, .snapshotTests]
    )
}

func makeNetworkConnectivityFeature() -> Module {
    return Module(
        name: "NetworkConnectivity",
        moduleType: .feature,
        path: "NetworkConnectivity",
        frameworkDependancies: [
            .external(name: "UDF"),
            .target(name: "Common"),
            .target(name: "Models"),
        ],
        frameworkResources: [],
        snapshotDependencies: [],
        targets: [.framework]
    )
}

func makeTabBarFeature() -> Module {
    return Module(
        name: "TabBar",
        moduleType: .feature,
        path: "TabBar",
        frameworkDependancies: [
            .external(name: "UDF"),
            .external(name: "SwiftFoundation"),
            .external(name: "SwiftUI-Kit"),
            .target(name: "DesignSystem"),
            .target(name: "Common"),
        ],
        frameworkResources: [],
        snapshotDependencies: snapshotCommonUDFDependencies,
        snapshotHostAppDependencies: [
            .external(name: "UDF"),
            .external(name: "SwiftFoundation"),
            .external(name: "SwiftUI-Kit"),
            .target(name: "Common"),
        ],
        targets: [.framework, .snapshotTests]
    )
}

func makeRootFeature() -> Module {
    return Module(
        name: "Root",
        moduleType: .feature,
        path: "Root",
        frameworkDependancies: [
            .external(name: "UDF"),
            .external(name: "SwiftFoundation"),
            .target(name: "Common"),
        ],
        frameworkResources: [],
        snapshotDependencies: snapshotCommonUDFDependencies,
        snapshotHostAppDependencies: [
            .external(name: "UDF"),
            .external(name: "SwiftFoundation"),
        ],
        targets: [.framework, .snapshotTests]
    )
}

func makeImageFeature() -> Module {
    return Module(
        name: "Image",
        moduleType: .feature,
        path: "Image",
        frameworkDependancies: [
            .external(name: "UDF"),
            .external(name: "SDWebImageSwiftUI"),
            .external(name: "SwiftUI-Kit"),
            .target(name: "API"),
            .target(name: "Models"),
            .target(name: "DesignSystem"),
            .target(name: "Common"),
        ],
        frameworkResources: [],
        snapshotDependencies: snapshotUDFDependencies,
        snapshotHostAppDependencies: [
            .external(name: "UDF"),
            .external(name: "SDWebImageSwiftUI"),
            .external(name: "SwiftUI-Kit"),
        ],
        targets: [.framework, .snapshotTests]
    )
}

func makeSectionDetails() -> Module {
    return Module(
        name: "SectionDetails",
        moduleType: .feature,
        path: "SectionDetails",
        frameworkDependancies: [
            .external(name: "UDF"),
            .external(name: "SwiftUI-Kit"),
            .target(name: "API"),
            .target(name: "Common"),
            .target(name: "Models"),
            .target(name: "DesignSystem"),
            .target(name: "CustomViews"),
        ],
        frameworkResources: [],
        snapshotDependencies: snapshotCommonModelsUDFDependencies,
        snapshotHostAppDependencies: [
            .external(name: "UDF"),
            .target(name: "Common"),
            .target(name: "Models"),
        ],
        targets: [.framework, .snapshotTests]
    )
}

func makeSearchFeature() -> Module {
    return Module(
        name: "Search",
        moduleType: .feature,
        path: "Search",
        frameworkDependancies: [
            .external(name: "UDF"),
            .external(name: "SwiftFoundation"),
            .target(name: "API"),
            .target(name: "Common"),
            .target(name: "Models"),
            .target(name: "CustomViews"),
            .target(name: "DesignSystem"),
            .target(name: "Localizations"),
        ],
        frameworkResources: [],
        snapshotDependencies: snapshotCommonModelsUDFDependencies,
        snapshotHostAppDependencies: [
            .external(name: "UDF"),
        ],
        targets: [.framework, .snapshotTests]
    )
}

func makeSettingsFeature() -> Module {
    return Module(
        name: "Settings",
        moduleType: .feature,
        path: "Settings",
        frameworkDependancies: [
            .external(name: "UDF"),
            .external(name: "SwiftUI-Kit"),
            .target(name: "Common"),
            .target(name: "Localizations"),
        ],
        frameworkResources: [],
        snapshotDependencies: snapshotUDFDependencies,
        snapshotHostAppDependencies: [
            .external(name: "UDF"),
            .external(name: "SwiftUI-Kit"),
        ],
        targets: [.framework, .snapshotTests]
    )
}

func makeMyFavoritesFeature() -> Module {
    return Module(
        name: "MyFavorites",
        moduleType: .feature,
        path: "MyFavorites",
        frameworkDependancies: [
            .external(name: "UDF"),
            .target(name: "API"),
            .target(name: "Models"),
            .target(name: "DesignSystem"),
            .target(name: "Localizations"),
            .target(name: "CustomViews"),
            .target(name: "Common"),
        ],
        frameworkResources: [],
        snapshotDependencies: snapshotCommonModelsUDFDependencies,
        snapshotHostAppDependencies: [
            .external(name: "UDF"),
        ],
        targets: [.framework, .snapshotTests]
    )
}

func makeItemDetailsFeature() -> Module {
    return Module(
        name: "ItemDetails",
        moduleType: .feature,
        path: "ItemDetails",
        frameworkDependancies: [
            .external(name: "UDF"),
            .external(name: "SwiftUI-Kit"),
            .target(name: "API"),
            .target(name: "Common"),
            .target(name: "Models"),
            .target(name: "DesignSystem"),
            .target(name: "Localizations"),
            .target(name: "CustomViews"),
        ],
        frameworkResources: [],
        snapshotDependencies: snapshotCommonModelsUDFDependencies,
        snapshotHostAppDependencies: [
            .external(name: "UDF"),
            .external(name: "SwiftUI-Kit"),
            .target(name: "Common"),
            .target(name: "Models"),
            .target(name: "ItemDetails"),
        ],
        targets: [.framework, .snapshotTests]
    )
}

func makeHomeFeature() -> Module {
    return Module(
        name: "Home",
        moduleType: .feature,
        path: "Home",
        frameworkDependancies: [
            .external(name: "UDF"),
            .target(name: "API"),
            .target(name: "Common"),
            .target(name: "Models"),
            .target(name: "Localizations"),
            .target(name: "CustomViews"),
        ],
        frameworkResources: [],
        snapshotDependencies: snapshotCommonModelsUDFDependencies,
        snapshotHostAppDependencies: snapshotCommonModelsUDFDependencies,
        targets: [.framework, .snapshotTests]
    )
}

func makeMainHomeSectionFeature() -> Module {
    return Module(
        name: "MainHomeSection",
        moduleType: .feature,
        path: "MainHomeSection",
        frameworkDependancies: [
            .external(name: "UDF"),
            .external(name: "SwiftUI-Kit"),
            .target(name: "Common"),
            .target(name: "Models"),
            .target(name: "CustomViews"),
        ],
        frameworkResources: [],
        snapshotDependencies: snapshotCommonModelsUDFDependencies,
        snapshotHostAppDependencies: [
            .external(name: "UDF"),
            .external(name: "SwiftUI-Kit"),
        ],
        targets: [.framework, .snapshotTests]
    )
}

func makeHomeSectionFeature() -> Module {
    return Module(
        name: "HomeSection",
        moduleType: .feature,
        path: "HomeSection",
        frameworkDependancies: [
            .external(name: "UDF"),
            .target(name: "Common"),
            .target(name: "Models"),
            .target(name: "DesignSystem"),
            .target(name: "CustomViews"),
        ],
        frameworkResources: [],
        snapshotDependencies: snapshotCommonModelsUDFDependencies,
        snapshotHostAppDependencies: [
            .external(name: "UDF"),
        ],
        targets: [.framework, .snapshotTests]
    )
}

func makeCastFeature() -> Module {
    return Module(
        name: "Cast",
        moduleType: .feature,
        path: "Cast",
        frameworkDependancies: [
            .external(name: "UDF"),
            .target(name: "Common"),
            .target(name: "Models"),
            .target(name: "DesignSystem"),
            .target(name: "CustomViews"),
            .target(name: "Localizations"),
        ],
        frameworkResources: [],
        snapshotDependencies: snapshotCommonModelsUDFDependencies,
        snapshotHostAppDependencies: [
            .external(name: "UDF"),
        ],
        targets: [.framework, .snapshotTests]
    )
}

func makeCastSectionFeature() -> Module {
    return Module(
        name: "CastSection",
        moduleType: .feature,
        path: "CastSection",
        frameworkDependancies: [
            .external(name: "UDF"),
            .target(name: "Common"),
            .target(name: "Models"),
            .target(name: "DesignSystem"),
            .target(name: "CustomViews"),
            .target(name: "Localizations"),
            .target(name: "API"),
        ],
        frameworkResources: [],
        snapshotDependencies: snapshotCommonModelsUDFDependencies,
        snapshotHostAppDependencies: snapshotCommonModelsUDFDependencies,
        targets: [.framework, .snapshotTests]
    )
}

func makeReviewDetailsFeature() -> Module {
    Module(
        name: "ReviewDetails",
        moduleType: .feature,
        path: "ReviewDetails",
        frameworkDependancies: [
            .external(name: "UDF"),
            .external(name: "SwiftUI-Kit"),
            .target(name: "API"),
            .target(name: "Common"),
            .target(name: "Models"),
            .target(name: "DesignSystem"),
            .target(name: "Localizations"),
            .target(name: "CustomViews"),
        ],
        frameworkResources: [],
        snapshotDependencies: snapshotCommonModelsUDFDependencies,
        snapshotHostAppDependencies: [
            .external(name: "UDF"),
            .external(name: "SwiftUI-Kit"),
        ],
        targets: [.framework, .snapshotTests]
    )
}

func makeReviewsFeature() -> Module {
    Module(
        name: "Reviews",
        moduleType: .feature,
        path: "Reviews",
        frameworkDependancies: [
            .external(name: "UDF"),
            .external(name: "SwiftUI-Kit"),
            .target(name: "Common"),
            .target(name: "Models"),
            .target(name: "DesignSystem"),
            .target(name: "Localizations"),
            .target(name: "CustomViews"),
            .target(name: "API")
        ],
        frameworkResources: [],
        snapshotDependencies: snapshotCommonModelsUDFDependencies,
        snapshotHostAppDependencies: [
            .external(name: "UDF"),
            .external(name: "SwiftUI-Kit"),
        ],
        targets: [.framework, .snapshotTests]
    )
}

func makeReviewsSectionFeature() -> Module {
    Module(
        name: "ReviewsSection",
        moduleType: .feature,
        path: "ReviewsSection",
        frameworkDependancies: [
            .external(name: "UDF"),
            .external(name: "SwiftUI-Kit"),
            .target(name: "Common"),
            .target(name: "Models"),
            .target(name: "DesignSystem"),
            .target(name: "Localizations"),
            .target(name: "CustomViews"),
            .target(name: "API")
        ],
        frameworkResources: [],
        snapshotDependencies: snapshotCommonModelsUDFDependencies,
        snapshotHostAppDependencies: [
            .external(name: "UDF"),
            .external(name: "SwiftUI-Kit"),
        ],
        targets: [.framework, .snapshotTests]
    )
}

func makeRecommendations() -> Module {
    Module(
        name: "Recommendations",
        moduleType: .feature,
        path: "Recommendations",
        frameworkDependancies: [
            .external(name: "UDF"),
            .external(name: "SwiftUI-Kit"),
            .target(name: "Common"),
            .target(name: "Models"),
            .target(name: "DesignSystem"),
            .target(name: "CustomViews"),
            .target(name: "API")
        ],
        frameworkResources: [],
        snapshotDependencies: snapshotCommonModelsUDFDependencies,
        snapshotHostAppDependencies: [
            .external(name: "UDF"),
            .external(name: "SwiftUI-Kit"),
            .target(name: "Common"),
            .target(name: "Models"),
        ],
        targets: [.framework, .snapshotTests]
    )
}

func makeRecommendationsSection() -> Module {
    Module(
        name: "RecommendationsSection",
        moduleType: .feature,
        path: "RecommendationsSection",
        frameworkDependancies: [
            .external(name: "UDF"),
            .external(name: "SwiftUI-Kit"),
            .target(name: "Common"),
            .target(name: "Models"),
            .target(name: "DesignSystem"),
            .target(name: "Localizations"),
            .target(name: "CustomViews"),
            .target(name: "API")
        ],
        frameworkResources: [],
        snapshotDependencies: snapshotCommonModelsUDFDependencies,
        snapshotHostAppDependencies: [
            .external(name: "UDF"),
            .external(name: "SwiftUI-Kit"),
            .target(name: "Common"),
            .target(name: "Models"),
        ],
        targets: [.framework, .snapshotTests]
    )
}
