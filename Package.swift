// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "WiFiScanner",
  dependencies: [
    .package(url: "https://github.com/scottrhoyt/SwiftyTextTable.git", from: "0.8.0")
  ],
  targets: [
    .target(
      name: "WiFiScanner",
      dependencies: [
        "SwiftyTextTable"
      ]),
  ]
)
