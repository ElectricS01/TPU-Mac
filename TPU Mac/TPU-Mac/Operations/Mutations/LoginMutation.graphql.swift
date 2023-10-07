// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

extension TPU-Mac {
  class LoginMutation: GraphQLMutation {
    static let operationName: String = "Login"
    static let operationDocument: ApolloAPI.OperationDocument = .init(
      definition: .init(
        #"mutation Login($input: LoginInput!) { login(input: $input) { __typename token user { __typename id username email } } }"#
      ))

    public var input: LoginInput

    public init(input: LoginInput) {
      self.input = input
    }

    public var __variables: Variables? { ["input": input] }

    struct Data: TPU-Mac.SelectionSet {
      let __data: DataDict
      init(_dataDict: DataDict) { __data = _dataDict }

      static var __parentType: ApolloAPI.ParentType { TPU-Mac.Objects.Mutation }
      static var __selections: [ApolloAPI.Selection] { [
        .field("login", Login.self, arguments: ["input": .variable("input")]),
      ] }

      var login: Login { __data["login"] }

      /// Login
      ///
      /// Parent Type: `LoginResponse`
      struct Login: TPU-Mac.SelectionSet {
        let __data: DataDict
        init(_dataDict: DataDict) { __data = _dataDict }

        static var __parentType: ApolloAPI.ParentType { TPU-Mac.Objects.LoginResponse }
        static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("token", String.self),
          .field("user", User.self),
        ] }

        var token: String { __data["token"] }
        var user: User { __data["user"] }

        /// Login.User
        ///
        /// Parent Type: `LoginUser`
        struct User: TPU-Mac.SelectionSet {
          let __data: DataDict
          init(_dataDict: DataDict) { __data = _dataDict }

          static var __parentType: ApolloAPI.ParentType { TPU-Mac.Objects.LoginUser }
          static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("id", Double.self),
            .field("username", String.self),
            .field("email", String.self),
          ] }

          var id: Double { __data["id"] }
          var username: String { __data["username"] }
          var email: String { __data["email"] }
        }
      }
    }
  }

}