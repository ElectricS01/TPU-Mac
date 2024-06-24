// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public struct DeleteUploadInput: InputObject {
  public private(set) var __data: InputDict

  public init(_ data: InputDict) {
    __data = data
  }

  public init(
    items: [Double]
  ) {
    __data = InputDict([
      "items": items
    ])
  }

  public var items: [Double] {
    get { __data["items"] }
    set { __data["items"] = newValue }
  }
}
