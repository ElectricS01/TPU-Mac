// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class LoginMutation: GraphQLMutation {
  public static let operationName: String = "Login"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation Login($input: LoginInput!) { login(input: $input) { __typename token user { __typename id username email } } }"#
    ))

  public var input: LoginInput

  public init(input: LoginInput) {
    self.input = input
  }

  public var __variables: Variables? { ["input": input] }

  public struct Data: PrivateUploaderAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { PrivateUploaderAPI.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("login", Login.self, arguments: ["input": .variable("input")]),
    ] }

    public var login: Login { __data["login"] }

    /// Login
    ///
    /// Parent Type: `LoginResponse`
    public struct Login: PrivateUploaderAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { PrivateUploaderAPI.Objects.LoginResponse }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("token", String.self),
        .field("user", User.self),
      ] }

      public var token: String { __data["token"] }
      public var user: User { __data["user"] }

      /// Login.User
      ///
      /// Parent Type: `LoginUser`
      public struct User: PrivateUploaderAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { PrivateUploaderAPI.Objects.LoginUser }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("id", Double.self),
          .field("username", String.self),
          .field("email", String.self),
        ] }

        public var id: Double { __data["id"] }
        public var username: String { __data["username"] }
        public var email: String { __data["email"] }
      }
    }
  }
}
