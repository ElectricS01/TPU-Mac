// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class UserProfileQuery: GraphQLQuery {
  public static let operationName: String = "UserProfile"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query UserProfile($input: UserProfileInput!) { user(input: $input) { __typename banner description id } }"#
    ))

  public var input: UserProfileInput

  public init(input: UserProfileInput) {
    self.input = input
  }

  public var __variables: Variables? { ["input": input] }

  public struct Data: PrivateUploaderAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { PrivateUploaderAPI.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("user", User?.self, arguments: ["input": .variable("input")]),
    ] }
    public static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
      UserProfileQuery.Data.self
    ] }

    public var user: User? { __data["user"] }

    /// User
    ///
    /// Parent Type: `PartialUserPublic`
    public struct User: PrivateUploaderAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: any ApolloAPI.ParentType { PrivateUploaderAPI.Objects.PartialUserPublic }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("banner", String?.self),
        .field("description", String?.self),
        .field("id", Int.self),
      ] }
      public static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
        UserProfileQuery.Data.User.self
      ] }

      public var banner: String? { __data["banner"] }
      public var description: String? { __data["description"] }
      public var id: Int { __data["id"] }
    }
  }
}
