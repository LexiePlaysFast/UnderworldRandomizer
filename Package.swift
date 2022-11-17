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
      ],
      resources: [
        .copy("Resources/Nioh 2/"),
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
