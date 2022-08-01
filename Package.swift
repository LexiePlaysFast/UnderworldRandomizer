// swift-tools-version: 5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "UnderworldRandomizer",
  dependencies: [
  ],
  targets: [
    .executableTarget(
      name: "dbur",
      dependencies: [
        "LibRando",
      ]
    ),
    .target(
      name: "LibRando",
      dependencies: [
      ]
    ),
    .testTarget(
      name: "RandoTests",
      dependencies: [
        "LibRando",
      ]
    ),
  ]
)
