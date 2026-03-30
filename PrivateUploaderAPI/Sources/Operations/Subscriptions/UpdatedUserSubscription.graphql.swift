// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI
@_spi(Execution) @_spi(Unsafe) import ApolloAPI

public struct UpdatedUserSubscription: GraphQLSubscription {
  public static let operationName: String = "UpdatedUser"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"subscription UpdatedUser { onUserStatus { __typename id status } }"#
    ))

  public init() {}

  public struct Data: PrivateUploaderAPI.SelectionSet {
    @_spi(Unsafe) public let __data: DataDict
    @_spi(Unsafe) public init(_dataDict: DataDict) { __data = _dataDict }

    @_spi(Execution) public static var __parentType: any ApolloAPI.ParentType { PrivateUploaderAPI.Objects.Subscription }
    @_spi(Execution) public static var __selections: [ApolloAPI.Selection] { [
      .field("onUserStatus", OnUserStatus.self),
    ] }
    @_spi(Execution) public static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
      UpdatedUserSubscription.Data.self
    ] }

    public var onUserStatus: OnUserStatus { __data["onUserStatus"] }

    /// OnUserStatus
    ///
    /// Parent Type: `StatusEvent`
    public struct OnUserStatus: PrivateUploaderAPI.SelectionSet {
      @_spi(Unsafe) public let __data: DataDict
      @_spi(Unsafe) public init(_dataDict: DataDict) { __data = _dataDict }

      @_spi(Execution) public static var __parentType: any ApolloAPI.ParentType { PrivateUploaderAPI.Objects.StatusEvent }
      @_spi(Execution) public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("id", Int.self),
        .field("status", GraphQLEnum<PrivateUploaderAPI.UserStatus>.self),
      ] }
      @_spi(Execution) public static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
        UpdatedUserSubscription.Data.OnUserStatus.self
      ] }

      public var id: Int { __data["id"] }
      public var status: GraphQLEnum<PrivateUploaderAPI.UserStatus> { __data["status"] }
    }
  }
}
