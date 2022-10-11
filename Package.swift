// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NistructLog",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "NistructLog",
            targets: ["NistructLog"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/SwiftyBeaver/SwiftyBeaver.git", .upToNextMajor(from: "1.9.0")),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "NistructLog",
            dependencies: ["SwiftyBeaver"]),
        .testTarget(
            name: "NistructLogTests",
            dependencies: ["NistructLog"]),
    ]
)
