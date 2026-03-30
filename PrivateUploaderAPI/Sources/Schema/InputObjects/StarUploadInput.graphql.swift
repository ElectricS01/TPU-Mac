// @generated
// This file was automatically generated and should not be edited.

@_spi(Internal) @_spi(Unsafe) import ApolloAPI

public struct StarUploadInput: InputObject {
  @_spi(Unsafe) public private(set) var __data: InputDict

  @_spi(Unsafe) public init(_ data: InputDict) {
    __data = data
  }

  public init(
    attachment: String
  ) {
    __data = InputDict([
      "attachment": attachment
    ])
  }

  /// The upload's attachment ID, not numerical ID, such as 1d7fe21g3jd1.png
  public var attachment: String {
    get { __data["attachment"] }
    set { __data["attachment"] = newValue }
  }
}
