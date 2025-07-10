// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "letter-clock",
    platforms: [
        .macOS(.v12)
    ],
    products: [
        .executable(name: "letter-clock", targets: ["LetterClock"])
    ],
    targets: [
        .executableTarget(
            name: "LetterClock",
            path: "Sources"
        )
    ]
) 