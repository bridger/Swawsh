// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "Swawsh",
    products: [
        .library(name: "Swawsh", targets: ["Swawsh"]),
    ],
    dependencies: [
        .package(url: "https://github.com/IBM-Swift/BlueCryptor.git", from: "1.0.0"),
    ],
    targets: [
        .target(name: "Swawsh", dependencies: ["Cryptor"]),
    ]
)