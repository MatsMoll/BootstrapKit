// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BootstrapKit",
    platforms: [
        .macOS(.v10_14),
    ],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "BootstrapKit",
            targets: ["BootstrapKit"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/vapor-community/HTMLKit", from: "2.0.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "BootstrapKit",
            dependencies: ["HTMLKit"]),
        .testTarget(
            name: "BootstrapKitTests",
            dependencies: ["BootstrapKit"]),
    ]
)
