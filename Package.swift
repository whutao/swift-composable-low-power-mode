// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "swift-composable-low-power-mode",
    platforms: [
        .iOS(.v13),
        .tvOS(.v13),
        .watchOS(.v6),
        .macOS(.v10_15),
        .macCatalyst(.v13)
    ],
    products: [
        .library(name: "ComposableLowPowerMode", targets: ["ComposableLowPowerMode"])
    ],
    dependencies: [
        .package(
            url: "https://github.com/pointfreeco/swift-dependencies",
            from: Version(1, 2, 0)
        ),
        .package(
            url: "https://github.com/whutao/swift-combine-extras",
            from: Version(1, 0, 0)
        )
    ],
    targets: [
        .target(name: "ComposableLowPowerMode", dependencies: [
            .product(name: "CombineExtras", package: "swift-combine-extras"),
            .product(name: "Dependencies", package: "swift-dependencies"),
            .product(name: "DependenciesMacros", package: "swift-dependencies")
        ])
    ]
)
