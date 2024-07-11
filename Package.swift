// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "MdocumentScanner",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "MdocumentScanner",
            targets: ["MdocumentScannerPlugin"])
    ],
    dependencies: [
        .package(url: "https://github.com/ionic-team/capacitor-swift-pm.git", branch: "main")
    ],
    targets: [
        .target(
            name: "MdocumentScannerPlugin",
            dependencies: [
                .product(name: "Capacitor", package: "capacitor-swift-pm"),
                .product(name: "Cordova", package: "capacitor-swift-pm")
            ],
            path: "ios/Sources/MdocumentScannerPlugin"),
        .testTarget(
            name: "MdocumentScannerPluginTests",
            dependencies: ["MdocumentScannerPlugin"],
            path: "ios/Tests/MdocumentScannerPluginTests")
    ]
)
