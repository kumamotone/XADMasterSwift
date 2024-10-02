// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "XADMasterSwift",
    platforms: [
        .macOS(.v10_13)
    ],
    products: [
        .library(
            name: "XADMasterSwift",
            targets: ["XADMasterSwift"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "XADMasterSwift",
            dependencies: ["XADMaster", "UniversalDetector"],
            path: "Sources"),
        .binaryTarget(
            name: "XADMaster",
            path: "Frameworks/XADMaster.xcframework"),
        .binaryTarget(
            name: "UniversalDetector",
            path: "Frameworks/UniversalDetector.xcframework")
    ]
)
