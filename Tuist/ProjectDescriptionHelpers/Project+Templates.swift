import ProjectDescription

let featuresPath = "Features"
let corePath = "Core"
let appPath = "Flick"
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
            return featuresPath
        case .app:
            return appPath
        }
    }
}

public struct Module {
    let name: String
    let path: String
    let frameworkDependancies: [TargetDependency]
    let frameworkResources: [String]
    let moduleType: ModuleType
    
    public init(
        name: String,
        moduleType: ModuleType,
        path: String,
        frameworkDependancies: [TargetDependency],
        frameworkResources: [String]
    ) {
        self.name = name
        self.path = path
        self.moduleType = moduleType
        self.frameworkDependancies = frameworkDependancies
        self.frameworkResources = frameworkResources
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
        let frameworkPath = "\(module.moduleType.path())/\(module.path)"
        
        let frameworkResourceFilePaths = module.frameworkResources.map {
            ResourceFileElement.glob(pattern: Path(stringLiteral: "\(module.moduleType.path())/\(module.path)/" + $0), tags: [])
        }
        
        
        var targets = [Target]()
        
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
            dependencies: module.frameworkDependancies,
        )
        
        targets.append(frameworkTarget)
        
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
            settings: settings
        )
        
        targets.append(mainTarget)
        return targets
    }
}
