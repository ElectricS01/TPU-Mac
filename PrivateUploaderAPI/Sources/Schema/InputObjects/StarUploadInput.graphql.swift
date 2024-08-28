// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public struct StarUploadInput: InputObject {
  public private(set) var __data: InputDict

  public init(_ data: InputDict) {
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
