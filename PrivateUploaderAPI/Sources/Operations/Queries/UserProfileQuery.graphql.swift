// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI
@_spi(Execution) @_spi(Unsafe) import ApolloAPI

public struct UserProfileQuery: GraphQLQuery {
  public static let operationName: String = "UserProfile"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query UserProfile($input: UserProfileInput!) { user(input: $input) { __typename banner description id } }"#
    ))

  public var input: UserProfileInput

  public init(input: UserProfileInput) {
    self.input = input
  }

  @_spi(Unsafe) public var __variables: Variables? { ["input": input] }

  public struct Data: PrivateUploaderAPI.SelectionSet {
    @_spi(Unsafe) public let __data: DataDict
    @_spi(Unsafe) public init(_dataDict: DataDict) { __data = _dataDict }

    @_spi(Execution) public static var __parentType: any ApolloAPI.ParentType { PrivateUploaderAPI.Objects.Query }
    @_spi(Execution) public static var __selections: [ApolloAPI.Selection] { [
      .field("user", User?.self, arguments: ["input": .variable("input")]),
    ] }
    @_spi(Execution) public static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
      UserProfileQuery.Data.self
    ] }

    public var user: User? { __data["user"] }

    /// User
    ///
    /// Parent Type: `PartialUserPublic`
    public struct User: PrivateUploaderAPI.SelectionSet {
      @_spi(Unsafe) public let __data: DataDict
      @_spi(Unsafe) public init(_dataDict: DataDict) { __data = _dataDict }

      @_spi(Execution) public static var __parentType: any ApolloAPI.ParentType { PrivateUploaderAPI.Objects.PartialUserPublic }
      @_spi(Execution) public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("banner", String?.self),
        .field("description", String?.self),
        .field("id", Int.self),
      ] }
      @_spi(Execution) public static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
        UserProfileQuery.Data.User.self
      ] }

      public var banner: String? { __data["banner"] }
      public var description: String? { __data["description"] }
      public var id: Int { __data["id"] }
    }
  }
}
