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
        makeOnboardingFeature(),
        makeSignInFeature(),
        makeWhereToWatch(),
        makeReviewDetails(),
        
        makeTabBarComponent(),
        makeImageComponent(),
        makeSectionDetailsComponent(),
        makeReviewsComponent(),
        makeItemDetailsReviewsComponent(),
        makeSearchComponent(),
        makeItemDetailsRecommendationsComponent(),
        makeSettingsComponent(),
        makeMyFavoritesComponent(),
        makeItemDetailsComponent(),
        makeHomeComponent(),
        makeMainHomeSectionComponent(),
        makeHomeSectionComponent(),
        makeCastComponent(),
        makeItemDetailsCastComponent(),
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
        snapshotDependencies: [
            .external(name: "SwiftUISnapshotTestCase"),
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

func makeWhereToWatch() -> Module {
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
        snapshotDependencies: [],
        targets: [.framework]
    )
}

func makeTabBarComponent() -> Module {
    return Module(
        name: "TabBarComponent",
        moduleType: .feature,
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
        moduleType: .feature,
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
        moduleType: .feature,
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
        moduleType: .feature,
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

func makeItemDetailsReviewsComponent() -> Module {
    return Module(
        name: "ItemDetailsReviewsComponent",
        moduleType: .feature,
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
        moduleType: .feature,
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
        moduleType: .feature,
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
        moduleType: .feature,
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
        moduleType: .feature,
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
        moduleType: .feature,
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
        moduleType: .feature,
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
        moduleType: .feature,
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
        moduleType: .feature,
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

func makeCastComponent() -> Module {
    return Module(
        name: "CastComponent",
        moduleType: .feature,
        path: "CastComponent",
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

func makeItemDetailsCastComponent() -> Module {
    return Module(
        name: "ItemDetailsCastComponent",
        moduleType: .feature,
        path: "ItemDetailsCastComponent",
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

func makeReviewDetails() -> Module{
    Module(
        name: "ReviewDetails",
        moduleType: .feature,
        path: "ReviewDetails",
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
