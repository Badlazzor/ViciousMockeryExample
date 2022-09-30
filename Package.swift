// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ViciousMockeryExample",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "ViciousMockeryExample",
            targets: ["ViciousMockeryExample"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/Badlazzor/ViciousMockery", branch: "main"),
        .package(url: "https://github.com/Quick/Quick", from: "5.0.0"),
        .package(url: "https://github.com/Quick/Nimble", from: "10.0.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "ViciousMockeryExample",
            dependencies: [
            ]
        ),
        .testTarget(
            name: "ViciousMockeryExampleTests",
            dependencies: [
                "ViciousMockeryExample",
                "Quick",
                "Nimble",
                .product(name: "ViciousMockery", package: "ViciousMockery"),
                .product(name: "Prestidigitation", package: "ViciousMockery"),
            ]
        ),
    ]
)
