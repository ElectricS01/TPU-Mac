// swift-tools-version:5.9

import PackageDescription

let package = Package(
  name: "PrivateUploaderAPI",
  platforms: [
    .iOS(.v12),
    .macOS(.v10_14),
    .tvOS(.v12),
    .watchOS(.v5),
  ],
  products: [
    .library(name: "PrivateUploaderAPI", targets: ["PrivateUploaderAPI"]),
  ],
  dependencies: [
    .package(url: "https://github.com/apollographql/apollo-ios", exact: "1.25.3"),
  ],
  targets: [
    .target(
      name: "PrivateUploaderAPI",
      dependencies: [
        .product(name: "ApolloAPI", package: "apollo-ios"),
      ],
      path: "./Sources"
    ),
  ]
)
