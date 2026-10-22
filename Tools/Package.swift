// swift-tools-version: 6.2

import PackageDescription

// Command-line tools used by the scripts and git hooks. Build one with
// `swift build --package-path Tools --configuration release --product <name>`.
let package = Package(
    name: "Tools",
    platforms: [
        .macOS(.v14),
    ],
    dependencies: [
        .package(url: "https://github.com/urlaunched-com/ModuleGraph.git", from: "1.0.0"),
    ],
    targets: []
)
