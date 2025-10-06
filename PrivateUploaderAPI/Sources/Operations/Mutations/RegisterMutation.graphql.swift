// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class RegisterMutation: GraphQLMutation {
  public static let operationName: String = "Register"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation Register($input: RegisterInput!) { register(input: $input) { __typename token } }"#
    ))

  public var input: RegisterInput

  public init(input: RegisterInput) {
    self.input = input
  }

  public var __variables: Variables? { ["input": input] }

  public struct Data: PrivateUploaderAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { PrivateUploaderAPI.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("register", Register.self, arguments: ["input": .variable("input")]),
    ] }

    public var register: Register { __data["register"] }

    /// Register
    ///
    /// Parent Type: `LoginResponse`
    public struct Register: PrivateUploaderAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: any ApolloAPI.ParentType { PrivateUploaderAPI.Objects.LoginResponse }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("token", String.self),
      ] }

      public var token: String { __data["token"] }
    }
  }
}
