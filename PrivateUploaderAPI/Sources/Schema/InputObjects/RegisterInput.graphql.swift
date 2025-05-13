// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public struct RegisterInput: InputObject {
  public private(set) var __data: InputDict

  public init(_ data: InputDict) {
    __data = data
  }

  public init(
    username: String,
    password: String,
    email: String,
    inviteKey: GraphQLNullable<String> = nil
  ) {
    __data = InputDict([
      "username": username,
      "password": password,
      "email": email,
      "inviteKey": inviteKey
    ])
  }

  public var username: String {
    get { __data["username"] }
    set { __data["username"] = newValue }
  }

  public var password: String {
    get { __data["password"] }
    set { __data["password"] = newValue }
  }

  public var email: String {
    get { __data["email"] }
    set { __data["email"] = newValue }
  }

  public var inviteKey: GraphQLNullable<String> {
    get { __data["inviteKey"] }
    set { __data["inviteKey"] = newValue }
  }
}
