import ProjectDescription

let featurePath = "Feature"
let corePath = "Core"
let appPath = "Flick"
let snapshotTestsHostAppPath = "SnapshotTestsHostApp"
let reverseOrganizationName = "com.urlaunched"
let infoPlistPath: Path = "Info.plist"

public enum ModuleType {
    case core
    case feature
    case app
    
    func path() -> String {
        switch self {
        case .core:
            return corePath
        case .feature:
            return featurePath
        case .app:
            return appPath
        }
    }
}

public enum FeatureTarget {
    case framework
    case snapshotTests
}

public struct Module {
    let name: String
    let path: String
    let frameworkDependancies: [TargetDependency]
    let frameworkResources: [String]
    let snapshotDependencies: [TargetDependency]
    let moduleType: ModuleType
    let frameworkScripts: [TargetScript]
    let targets: Set<FeatureTarget>
    
    public init(
        name: String,
        moduleType: ModuleType,
        path: String,
        frameworkDependancies: [TargetDependency],
        frameworkResources: [String],
        snapshotDependencies: [TargetDependency] = [],
        frameworkScripts: [TargetScript] = [],
        targets: Set<FeatureTarget> = Set(arrayLiteral: .framework)
    ) {
        self.name = name
        self.path = path
        self.moduleType = moduleType
        self.frameworkDependancies = frameworkDependancies
        self.frameworkResources = frameworkResources
        self.snapshotDependencies = snapshotDependencies
        self.frameworkScripts = frameworkScripts
        self.targets = targets
    }
}

extension Project {
    public static func app(
        name: String,
        organizationName: String,
        packages: [Package] = [],
        settings: Settings? = nil,
        appSettings: Settings? = nil,
        dependencies: [TargetDependency] = [],
        targetDependancies: [TargetDependency] = [],
        moduleTargets: [Module],
    ) -> Project {
        let organizationName = organizationName
        var targets = [Target]()
        var dependencies = moduleTargets.map { TargetDependency.target(name: $0.name) }
        dependencies.append(contentsOf: targetDependancies)
        
        let appTargets = makeAppTargets(
            name: name,
            dependencies: dependencies,
            settings: appSettings
        )
        targets.append(contentsOf: appTargets)
        
        targets += moduleTargets.flatMap({ makeFrameworkTargets(module: $0) })
        
        
        return Project(
            name: name,
            organizationName: organizationName,
            packages: packages,
            settings: settings,
            targets: targets
        )
    }
    
    public static func makeFrameworkTargets(module: Module) -> [Target] {
        var targets = [Target]()
        let frameworkPath = "\(module.moduleType.path())/\(module.path)"
        let frameworkResourceFilePaths = module.frameworkResources.map {
            ResourceFileElement.glob(pattern: Path(stringLiteral: "\(module.moduleType.path())/\(module.path)/" + $0), tags: [])
        }
        
        if module.targets.contains(.framework) {
            let frameworkTarget = Target.target(
                name: module.name,
                destinations: .iOS,
                product: .framework,
                bundleId: "\(reverseOrganizationName).\(module.name)",
                infoPlist: .default,
                sources: [
                    "\(frameworkPath)/Sources/**",
                ],
                resources: .resources(frameworkResourceFilePaths),
                scripts: module.frameworkScripts,
                dependencies: module.frameworkDependancies,
            )
            
            targets.append(frameworkTarget)
        }
        
        if module.targets.contains(.snapshotTests) {
            let settings: Settings = .settings(
                configurations: [
                    .debug(name: "Debug", xcconfig: "./xcconfigs/SnapshotTests.xcconfig"),
                    .release(name: "Release", xcconfig: "./xcconfigs/SnapshotTests.xcconfig"),
                ]
            )
            let hostAppName = "\(module.name)SnapshotTestsHostApp"
            let appTarget = Target.target(
                name: hostAppName,
                destinations: .iOS,
                product: .app,
                bundleId: "\(reverseOrganizationName).\(module.name).app",
                infoPlist: .extendingDefault(with: [
                    "UIMainStoryboardFile": "",
                    "UILaunchStoryboardName": "LaunchScreen"
                ]),
                sources: [
                    "\(frameworkPath)/App/**",
                ],
                resources: .resources(frameworkResourceFilePaths),
                dependencies: module.frameworkDependancies + [
                    .target(name: module.name)
                ],
            )
            
            let snapshotTarget = Target.target(
                name: "\(module.name)SnapshotTests",
                destinations: .iOS,
                product: .unitTests,
                bundleId: "\(reverseOrganizationName).\(module.name)SnapshotTests",
                infoPlist: .default,
                sources: [
                    "\(frameworkPath)/Snapshots/**",
                    "SnapshotTest/**"
                ],
                resources: ["\(frameworkPath)/Snapshots/__Snapshots__/**"],
                dependencies: module.snapshotDependencies + [
                    .target(name: module.name),
                    .target(name: hostAppName),
                    .sdk(name: "XCTest", type: .framework, status: .required)
                ],
                settings: settings
            )
            
            targets.append(appTarget)
            targets.append(snapshotTarget)
        }
        
        return targets
    }
    
    
    public static func makeAppTargets(
        name: String,
        dependencies: [TargetDependency],
        settings: Settings? = nil
    ) -> [Target] {
        var targets = [Target]()
        
        let mainTarget = Target.target(
            name: name,
            destinations: .iOS,
            product: .app,
            bundleId: "\(reverseOrganizationName).\(name)",
            infoPlist: .file(path: infoPlistPath),
            sources: ["\(appPath)/Sources/**"],
            resources: ["\(appPath)/Resources/**"],
            dependencies: dependencies,
            settings: settings,
        )
        
        targets.append(mainTarget)
        return targets
    }
}
