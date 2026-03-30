// @generated
// This file was automatically generated and should not be edited.

@_spi(Internal) @_spi(Unsafe) import ApolloAPI

public struct DeleteUploadInput: InputObject {
  @_spi(Unsafe) public private(set) var __data: InputDict

  @_spi(Unsafe) public init(_ data: InputDict) {
    __data = data
  }

  public init(
    items: [Int32]
  ) {
    __data = InputDict([
      "items": items
    ])
  }

  public var items: [Int32] {
    get { __data["items"] }
    set { __data["items"] = newValue }
  }
}
