// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "HouseHunter",
    products: [
        .library(name: "HouseHunter", targets: ["App"]),
    ],
    dependencies: [
        // 🚍 It's like Netty, but written for Swift.
        .package(url: "https://github.com/apple/swift-nio.git", from: "1.0.0"),
        // 📝 It's like a logger, but written in Swift.
        // .package(url: "https://github.com/apple/swift-log.git", from: "1.0.0"),
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "3.0.0"),
        // 🔵 Swift ORM (queries, models, relations, etc) built on SQLite 3.
        // .package(url: "https://github.com/vapor/fluent-sqlite.git", from: "3.0.0"),
        // 🥬 Driver for MongoDB.
        // .package(url: "https://github.com/mongodb/mongo-swift-driver.git", .upToNextMajor(from: "0.2.0")),
        // 🖌
        .package(url: "https://github.com/tid-kijyun/Kanna.git", .upToNextMajor(from: "5.0.0")),
    ],
    targets: [
        .target(name: "App", dependencies: ["NIO", "Vapor", "Kanna"]),
        .target(name: "Run", dependencies: ["App"]),
        .testTarget(name: "AppTests", dependencies: ["App"])
    ]
)

