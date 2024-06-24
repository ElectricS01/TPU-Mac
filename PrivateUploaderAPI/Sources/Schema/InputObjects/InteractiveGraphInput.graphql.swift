// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public struct InteractiveGraphInput: InputObject {
  public private(set) var __data: InputDict

  public init(_ data: InputDict) {
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
