// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public struct DeleteMessageInput: InputObject {
  public private(set) var __data: InputDict

  public init(_ data: InputDict) {
    __data = data
  }

  public init(
    messageId: Int,
    associationId: Int
  ) {
    __data = InputDict([
      "messageId": messageId,
      "associationId": associationId
    ])
  }

  public var messageId: Int {
    get { __data["messageId"] }
    set { __data["messageId"] = newValue }
  }

  public var associationId: Int {
    get { __data["associationId"] }
    set { __data["associationId"] = newValue }
  }
}
