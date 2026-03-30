// @generated
// This file was automatically generated and should not be edited.

@_spi(Internal) @_spi(Unsafe) import ApolloAPI

public struct DeleteMessageInput: InputObject {
  @_spi(Unsafe) public private(set) var __data: InputDict

  @_spi(Unsafe) public init(_ data: InputDict) {
    __data = data
  }

  public init(
    messageId: Int32,
    associationId: Int32
  ) {
    __data = InputDict([
      "messageId": messageId,
      "associationId": associationId
    ])
  }

  public var messageId: Int32 {
    get { __data["messageId"] }
    set { __data["messageId"] = newValue }
  }

  public var associationId: Int32 {
    get { __data["associationId"] }
    set { __data["associationId"] = newValue }
  }
}
