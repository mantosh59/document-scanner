// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "EgDocScanner",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "EgDocScanner",
            targets: ["EGDocScannerPlugin"])
    ],
    dependencies: [
        .package(url: "https://github.com/ionic-team/capacitor-swift-pm.git", branch: "main")
    ],
    targets: [
        .target(
            name: "EGDocScannerPlugin",
            dependencies: [
                .product(name: "Capacitor", package: "capacitor-swift-pm"),
                .product(name: "Cordova", package: "capacitor-swift-pm")
            ],
            path: "ios/Sources/EGDocScannerPlugin"),
        .testTarget(
            name: "EGDocScannerPluginTests",
            dependencies: ["EGDocScannerPlugin"],
            path: "ios/Tests/EGDocScannerPluginTests")
    ]
)
