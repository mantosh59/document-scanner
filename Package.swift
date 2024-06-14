// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "MDocumentScanner",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "MDocumentScanner",
            targets: ["MDocumentScannerPlugin"])
    ],
    dependencies: [
        .package(url: "https://github.com/ionic-team/capacitor-swift-pm.git", branch: "main")
    ],
    targets: [
        .target(
            name: "MDocumentScannerPlugin",
            dependencies: [
                .product(name: "Capacitor", package: "capacitor-swift-pm"),
                .product(name: "Cordova", package: "capacitor-swift-pm")
            ],
            path: "ios/Sources/MDocumentScannerPlugin"),
        .testTarget(
            name: "MDocumentScannerPluginTests",
            dependencies: ["MDocumentScannerPlugin"],
            path: "ios/Tests/MDocumentScannerPluginTests")
    ]
)
