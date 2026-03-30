// @generated
// This file was automatically generated and should not be edited.

@_spi(Internal) @_spi(Unsafe) import ApolloAPI

public struct InteractiveGraphInput: InputObject {
  @_spi(Unsafe) public private(set) var __data: InputDict

  @_spi(Unsafe) public init(_ data: InputDict) {
    __data = data
  }

  public init(
    type: String
  ) {
    __data = InputDict([
      "type": type
    ])
  }

  public var type: String {
    get { __data["type"] }
    set { __data["type"] = newValue }
  }
}
