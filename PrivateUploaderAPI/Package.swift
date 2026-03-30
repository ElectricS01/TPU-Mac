// swift-tools-version:6.1

import PackageDescription

let package = Package(
  name: "PrivateUploaderAPI",
  platforms: [
    .iOS(.v15),
    .macOS(.v12),
    .tvOS(.v15),
    .watchOS(.v8),
    .visionOS(.v1),
  ],
  products: [
    .library(name: "PrivateUploaderAPI", targets: ["PrivateUploaderAPI"]),
  ],
  dependencies: [
    .package(url: "https://github.com/apollographql/apollo-ios", exact: "2.1.0-rc-1"),
  ],
  targets: [
    .target(
      name: "PrivateUploaderAPI",
      dependencies: [
        .product(name: "ApolloAPI", package: "apollo-ios"),
      ],
      path: "./Sources"
    ),
  ],
  swiftLanguageModes: [.v6, .v5]
)
