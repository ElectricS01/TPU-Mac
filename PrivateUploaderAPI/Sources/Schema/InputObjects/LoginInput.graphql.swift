// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public struct LoginInput: InputObject {
  public private(set) var __data: InputDict

  public init(_ data: InputDict) {
    __data = data
  }

  public init(
    username: String,
    password: String,
    totp: GraphQLNullable<String> = nil
  ) {
    __data = InputDict([
      "username": username,
      "password": password,
      "totp": totp
    ])
  }

  /// Username or email
  public var username: String {
    get { __data["username"] }
    set { __data["username"] = newValue }
  }

  public var password: String {
    get { __data["password"] }
    set { __data["password"] = newValue }
  }

  /// TOTP/2FA code if enabled.
  public var totp: GraphQLNullable<String> {
    get { __data["totp"] }
    set { __data["totp"] = newValue }
  }
}
