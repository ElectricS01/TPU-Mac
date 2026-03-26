// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public struct UserProfileInput: InputObject {
  public private(set) var __data: InputDict

  public init(_ data: InputDict) {
    __data = data
  }

  public init(
    id: GraphQLNullable<Int> = nil,
    username: GraphQLNullable<String> = nil
  ) {
    __data = InputDict([
      "id": id,
      "username": username
    ])
  }

  public var id: GraphQLNullable<Int> {
    get { __data["id"] }
    set { __data["id"] = newValue }
  }

  public var username: GraphQLNullable<String> {
    get { __data["username"] }
    set { __data["username"] = newValue }
  }
}
