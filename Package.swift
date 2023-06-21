// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "CleemaSupport",
    platforms: [
        .macOS(.v10_15)
    ],
    dependencies: [
        .package(name: "swiftkeys", url: "git@gitlab.kfi.io:tooligans/swiftkeys.git", from: "0.2.5")
    ]
)
