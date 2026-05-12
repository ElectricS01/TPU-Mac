// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public struct AddFriendInput: InputObject {
  public private(set) var __data: InputDict

  public init(_ data: InputDict) {
    __data = data
  }

  public init(
    userId: GraphQLNullable<Int> = nil,
    username: GraphQLNullable<String> = nil,
    action: GraphQLNullable<GraphQLEnum<FriendAction>> = nil
  ) {
    __data = InputDict([
      "userId": userId,
      "username": username,
      "action": action
    ])
  }

  /// Can use `userId` or `username`
  public var userId: GraphQLNullable<Int> {
    get { __data["userId"] }
    set { __data["userId"] = newValue }
  }

  /// Can use `userId` or `username`
  public var username: GraphQLNullable<String> {
    get { __data["username"] }
    set { __data["username"] = newValue }
  }

  /// If null, it works as a toggle. This is for explicit actions.
  public var action: GraphQLNullable<GraphQLEnum<FriendAction>> {
    get { __data["action"] }
    set { __data["action"] = newValue }
  }
}
