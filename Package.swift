// swift-tools-version:5.3
import PackageDescription
let package = Package(
    name: "FreshworksSDK",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "FreshworksSDK",
            targets: ["FreshworksSDK"]),
    ],
    targets: [
        .binaryTarget(
            name: "FreshworksSDK",
            path: "FreshworksSDK.xcframework"
        ),
    ]
)
