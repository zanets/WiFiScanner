// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "WiFiScanner-MacOS",
  dependencies: [
    .package(url: "https://github.com/scottrhoyt/SwiftyTextTable.git", from: "0.5.0")
  ],
  targets: [
    .target(
      name: "WiFiScanner-MacOS",
      dependencies: [
        "SwiftyTextTable"
      ]),
  ]
)
