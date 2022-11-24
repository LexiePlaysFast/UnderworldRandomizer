// swift-tools-version: 5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "UnderworldRandomizer",
  products: [
    .library(
      name: "LibRando",
      targets: [
        "LibRando"
      ]
    ),
    .library(
      name: "LibSeeded",
      targets: [
        "LibSeeded"
      ]
    ),
  ],
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
    .target(
      name: "LibSeeded",
      dependencies: [
      ]
    ),
    .testTarget(
      name: "SeededTests",
      dependencies: [
        "LibSeeded",
      ]
    ),
  ]
)
