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
        // A local checkout for now; becomes `.package(url:from:)` once module-graph has its own repository.
        .package(path: "../../../Experiments/ModuleGraph"),
    ],
    targets: []
)
