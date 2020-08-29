// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "VaporMustache",
    platforms: [
       .macOS(.v10_15)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "VaporMustache",
            targets: ["VaporMustache"]),
    ],
    dependencies: [
        .package(name: "Mustache", url: "https://github.com/groue/GRMustache.swift.git", from: "4.0.1"),
        .package(url: "https://github.com/vapor/vapor.git", from: "4.0.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "VaporMustache",
            dependencies: [.product(name: "Vapor", package: "vapor"),.product(name: "Mustache", package: "Mustache")]),
        .testTarget(
            name: "VaporMustacheTests",
            dependencies: ["VaporMustache",.product(name: "XCTVapor", package: "vapor")],
            resources: [.process("test.mustache")]),
    ]
)
