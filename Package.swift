// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "DisplayArranger",
    platforms: [
        .macOS(.v10_13)
    ],
    products: [
        .executable(
            name: "display-arranger",
            targets: ["DisplayArranger"]
        )
    ],
    dependencies: [],
    targets: [
        .executableTarget(
            name: "DisplayArranger",
            dependencies: [],
            path: "Sources/DisplayArranger"
        ),
        // .testTarget(
        //     name: "DisplayArrangerTests",
        //     dependencies: ["DisplayArranger"],
        //     path: "Tests/DisplayArranger"
        // )
    ]
)
