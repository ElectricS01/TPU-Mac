// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

extension TPU-Mac {
  struct LoginInput: InputObject {
    private(set) var __data: InputDict

    init(_ data: InputDict) {
      __data = data
    }

    init(
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
    var username: String {
      get { __data["username"] }
      set { __data["username"] = newValue }
    }

    var password: String {
      get { __data["password"] }
      set { __data["password"] = newValue }
    }

    /// TOTP/2FA code if enabled.
    var totp: GraphQLNullable<String> {
      get { __data["totp"] }
      set { __data["totp"] = newValue }
    }
  }

}