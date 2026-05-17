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
    ],
    settings: settings,
    appSettings: appSettings,
    targetDependancies: [
        .external(name: "FlagKit"),
        .external(name: "SDWebImageSwiftUI"),
        .external(name: "UDF"),
        .external(name: "SwiftFoundation"),
        .external(name: "SwiftUI-Kit"),
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
        makeOnboardingUIComponent(),
        makeOnboardingSignInComponent(),
        makeWhereToWatchComponent(),
        makeTabBarComponent(),
        makeImageComponent(),
        makeSectionDetailsComponent(),
        makeReviewsComponent(),
        makeReviewDetailsComponent(),
        makeItemDetailsReviewsComponent(),
        makeSearchComponent(),
        makeItemDetailsRecommendationsComponent(),
        makeSettingsComponent(),
        makeMyFavoritesComponent(),
        makeItemDetailsComponent(),
        makeHomeComponent(),
        makeMainHomeSectionComponent(),
        makeHomeSectionComponent(),
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
            .external(name: "SwiftUI-Kit"),
            .external(name: "SDWebImageSwiftUI"),
            .target(name: "DesignSystem"),
            .target(name: "Models"),
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

func makeOnboardingUIComponent() -> Module {
    return Module(
        name: "OnboardingComponent",
        moduleType: .ui,
        path: "OnboardingComponent",
        frameworkDependancies: [
            .external(name: "UDF"),
            .external(name: "SwiftUI-Kit"),
            .target(name: "DesignSystem"),
            .target(name: "Localizations"),
            .external(name: "RswiftLibrary")
        ],
        frameworkResources: [],
        snapshotDependencies: [
            .external(name: "SwiftUISnapshotTestCase"),
        ],
        targets: [.framework, .snapshotTests]
    )
}

func makeOnboardingSignInComponent() -> Module {
    return Module(
        name: "SignInComponent",
        moduleType: .ui,
        path: "SignInComponent",
        frameworkDependancies: [
            .external(name: "UDF"),
            .target(name: "DesignSystem"),
            .target(name: "Localizations"),
            .external(name: "RswiftLibrary"),
            .target(name: "Common"),
        ],
        frameworkResources: [],
        snapshotDependencies: [
            .external(name: "SwiftUISnapshotTestCase"),
        ],
        targets: [.framework, .snapshotTests]
    )
}

func makeWhereToWatchComponent() -> Module {
    return Module(
        name: "WhereToWatchComponent",
        moduleType: .ui,
        path: "WhereToWatchComponent",
        frameworkDependancies: [
            .external(name: "UDF"),
            .target(name: "Localizations"),
            .external(name: "RswiftLibrary"),
            .target(name: "Common"),
            .target(name: "Models"),
            .external(name: "FlagKit"),
        ],
        frameworkResources: [],
        snapshotDependencies: [],
        targets: [.framework]
    )
}

func makeTabBarComponent() -> Module {
    return Module(
        name: "TabBarComponent",
        moduleType: .ui,
        path: "TabBarComponent",
        frameworkDependancies: [
            .external(name: "UDF"),
            .external(name: "SwiftUI-Kit"),
            .target(name: "DesignSystem"),
            .target(name: "Common"),
        ],
        frameworkResources: [],
        snapshotDependencies: [],
        targets: [.framework]
    )
}

func makeImageComponent() -> Module {
    return Module(
        name: "ImageComponent",
        moduleType: .ui,
        path: "ImageComponent",
        frameworkDependancies: [
            .external(name: "UDF"),
            .external(name: "SDWebImageSwiftUI"),
            .external(name: "SwiftUI-Kit"),
            .target(name: "DesignSystem"),
            .target(name: "Common"),
        ],
        frameworkResources: [],
        snapshotDependencies: [],
        targets: [.framework]
    )
}

func makeSectionDetailsComponent() -> Module {
    return Module(
        name: "SectionDetailsComponent",
        moduleType: .ui,
        path: "SectionDetailsComponent",
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

func makeReviewsComponent() -> Module {
    return Module(
        name: "ReviewsComponent",
        moduleType: .ui,
        path: "ReviewsComponent",
        frameworkDependancies: [
            .external(name: "UDF"),
            .target(name: "Common"),
            .target(name: "Models"),
            .target(name: "CustomViews"),
        ],
        frameworkResources: [],
        snapshotDependencies: [],
        targets: [.framework]
    )
}

func makeReviewDetailsComponent() -> Module {
    return Module(
        name: "ReviewDetailsComponent",
        moduleType: .ui,
        path: "ReviewDetailsComponent",
        frameworkDependancies: [
            .external(name: "UDF"),
            .target(name: "Common"),
            .target(name: "Models"),
            .target(name: "CustomViews"),
            .target(name: "DesignSystem"),
            .target(name: "Localizations"),
        ],
        frameworkResources: [],
        snapshotDependencies: [],
        targets: [.framework]
    )
}

func makeItemDetailsReviewsComponent() -> Module {
    return Module(
        name: "ItemDetailsReviewsComponent",
        moduleType: .ui,
        path: "ItemDetailsReviewsComponent",
        frameworkDependancies: [
            .external(name: "UDF"),
            .target(name: "Models"),
            .target(name: "CustomViews"),
            .target(name: "DesignSystem"),
            .target(name: "Localizations"),
        ],
        frameworkResources: [],
        snapshotDependencies: [],
        targets: [.framework]
    )
}

func makeSearchComponent() -> Module {
    return Module(
        name: "SearchComponent",
        moduleType: .ui,
        path: "SearchComponent",
        frameworkDependancies: [
            .external(name: "UDF"),
            .target(name: "Models"),
            .target(name: "CustomViews"),
            .target(name: "DesignSystem"),
            .target(name: "Localizations"),
        ],
        frameworkResources: [],
        snapshotDependencies: [],
        targets: [.framework]
    )
}

func makeItemDetailsRecommendationsComponent() -> Module {
    return Module(
        name: "ItemDetailsRecommendationsComponent",
        moduleType: .ui,
        path: "ItemDetailsRecommendationsComponent",
        frameworkDependancies: [
            .external(name: "UDF"),
            .target(name: "Models"),
            .target(name: "CustomViews"),
            .target(name: "DesignSystem"),
            .target(name: "Localizations"),
            .target(name: "Common"),
        ],
        frameworkResources: [],
        snapshotDependencies: [],
        targets: [.framework]
    )
}

func makeSettingsComponent() -> Module {
    return Module(
        name: "SettingsComponent",
        moduleType: .ui,
        path: "SettingsComponent",
        frameworkDependancies: [
            .external(name: "UDF"),
            .external(name: "SwiftUI-Kit"),
            .target(name: "Common"),
            .target(name: "Localizations"),
        ],
        frameworkResources: [],
        snapshotDependencies: [],
        targets: [.framework]
    )
}

func makeMyFavoritesComponent() -> Module {
    return Module(
        name: "MyFavoritesComponent",
        moduleType: .ui,
        path: "MyFavoritesComponent",
        frameworkDependancies: [
            .external(name: "UDF"),
            .target(name: "Models"),
            .target(name: "DesignSystem"),
            .target(name: "Localizations"),
            .target(name: "CustomViews"),
            .target(name: "Common"),
        ],
        frameworkResources: [],
        snapshotDependencies: [],
        targets: [.framework]
    )
}

func makeItemDetailsComponent() -> Module {
    return Module(
        name: "ItemDetailsComponent",
        moduleType: .ui,
        path: "ItemDetailsComponent",
        frameworkDependancies: [
            .external(name: "UDF"),
            .external(name: "SwiftUI-Kit"),
            .target(name: "Common"),
            .target(name: "Models"),
            .target(name: "DesignSystem"),
            .target(name: "Localizations"),
            .target(name: "CustomViews"),
        ],
        frameworkResources: [],
        snapshotDependencies: [],
        targets: [.framework]
    )
}

func makeHomeComponent() -> Module {
    return Module(
        name: "HomeComponent",
        moduleType: .ui,
        path: "HomeComponent",
        frameworkDependancies: [
            .external(name: "UDF"),
            .external(name: "SwiftUI-Kit"),
            .target(name: "Common"),
            .target(name: "Models"),
            .target(name: "DesignSystem"),
            .target(name: "Localizations"),
            .target(name: "CustomViews"),
        ],
        frameworkResources: [],
        snapshotDependencies: [],
        targets: [.framework]
    )
}

func makeMainHomeSectionComponent() -> Module {
    return Module(
        name: "MainHomeSectionComponent",
        moduleType: .ui,
        path: "MainHomeSectionComponent",
        frameworkDependancies: [
            .external(name: "UDF"),
            .external(name: "SwiftUI-Kit"),
            .target(name: "Common"),
            .target(name: "Models"),
            .target(name: "DesignSystem"),
            .target(name: "Localizations"),
            .target(name: "CustomViews"),
        ],
        frameworkResources: [],
        snapshotDependencies: [],
        targets: [.framework]
    )
}

func makeHomeSectionComponent() -> Module {
    return Module(
        name: "HomeSectionComponent",
        moduleType: .ui,
        path: "HomeSectionComponent",
        frameworkDependancies: [
            .external(name: "UDF"),
            .external(name: "SwiftUI-Kit"),
            .target(name: "Common"),
            .target(name: "Models"),
            .target(name: "DesignSystem"),
            .target(name: "Localizations"),
            .target(name: "CustomViews"),
        ],
        frameworkResources: [],
        snapshotDependencies: [],
        targets: [.framework]
    )
}
