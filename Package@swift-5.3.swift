// swift-tools-version:5.3
import PackageDescription

//#if os(Linux)
//let libraryType: PackageDescription.Product.Library.LibraryType = .dynamic
//let supportedPlatforms: [SupportedPlatform]? = nil
//#else
//let libraryType: PackageDescription.Product.Library.LibraryType = .static
//let supportedPlatforms: [SupportedPlatform]? = [
//    // Add support for all platforms starting from a specific version.
//    .macOS(.v10_12),
//    .iOS(.v10),
//    .watchOS(.v3),
//    .tvOS(.v10)
//]
//#endif

let package = Package(
    name: "GATT",
//    platforms: supportedPlatforms,
    products: [
        .library(
            name: "GATT",
            type: .static,
            targets: ["GATT"]
        ),
        .library(
            name: "DarwinGATT",
            type: .static,
            targets: ["DarwinGATT"]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/DrAma999/Bluetooth.git",
            .branch("master")
        )
    ],
    targets: [
        .target(
            name: "GATT",
            dependencies: [
                .product(
                    name: "Bluetooth",
                    package: "Bluetooth"
                ),
                .product(
                    name: "BluetoothGATT",
                    package: "Bluetooth",
                    condition: .when(platforms: [.macOS, .linux])
                ),
                .product(
                    name: "BluetoothGAP",
                    package: "Bluetooth",
                    condition: .when(platforms: [.macOS, .linux])
                ),
                .product(
                    name: "BluetoothHCI",
                    package: "Bluetooth",
                    condition: .when(platforms: [.macOS, .linux])
                ),
            ]
        ),
        .target(
            name: "DarwinGATT",
            dependencies: [
                "GATT",
                .product(
                    name: "BluetoothGATT",
                    package: "Bluetooth",
                    condition: .when(platforms: [.macOS])
                )
            ]
        ),
        .testTarget(
            name: "GATTTests",
            dependencies: [
                "GATT",
                .product(
                    name: "Bluetooth",
                    package: "Bluetooth"
                ),
                .product(
                    name: "BluetoothGATT",
                    package: "Bluetooth"
                ),
                .product(
                    name: "BluetoothGAP",
                    package: "Bluetooth"
                ),
                .product(
                    name: "BluetoothHCI",
                    package: "Bluetooth"
                )
            ]
        )
    ]
)
