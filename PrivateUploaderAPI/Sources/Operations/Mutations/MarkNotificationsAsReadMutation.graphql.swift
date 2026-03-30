// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI
@_spi(Execution) @_spi(Unsafe) import ApolloAPI

public struct MarkNotificationsAsReadMutation: GraphQLMutation {
  public static let operationName: String = "MarkNotificationsAsRead"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation MarkNotificationsAsRead { markNotificationsAsRead { __typename id dismissed message route createdAt } }"#
    ))

  public init() {}

  public struct Data: PrivateUploaderAPI.SelectionSet {
    @_spi(Unsafe) public let __data: DataDict
    @_spi(Unsafe) public init(_dataDict: DataDict) { __data = _dataDict }

    @_spi(Execution) public static var __parentType: any ApolloAPI.ParentType { PrivateUploaderAPI.Objects.Mutation }
    @_spi(Execution) public static var __selections: [ApolloAPI.Selection] { [
      .field("markNotificationsAsRead", [MarkNotificationsAsRead].self),
    ] }
    @_spi(Execution) public static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
      MarkNotificationsAsReadMutation.Data.self
    ] }

    public var markNotificationsAsRead: [MarkNotificationsAsRead] { __data["markNotificationsAsRead"] }

    /// MarkNotificationsAsRead
    ///
    /// Parent Type: `Notification`
    public struct MarkNotificationsAsRead: PrivateUploaderAPI.SelectionSet {
      @_spi(Unsafe) public let __data: DataDict
      @_spi(Unsafe) public init(_dataDict: DataDict) { __data = _dataDict }

      @_spi(Execution) public static var __parentType: any ApolloAPI.ParentType { PrivateUploaderAPI.Objects.Notification }
      @_spi(Execution) public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("id", Int.self),
        .field("dismissed", Bool.self),
        .field("message", String.self),
        .field("route", String?.self),
        .field("createdAt", PrivateUploaderAPI.Date.self),
      ] }
      @_spi(Execution) public static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
        MarkNotificationsAsReadMutation.Data.MarkNotificationsAsRead.self
      ] }

      public var id: Int { __data["id"] }
      public var dismissed: Bool { __data["dismissed"] }
      public var message: String { __data["message"] }
      public var route: String? { __data["route"] }
      public var createdAt: PrivateUploaderAPI.Date { __data["createdAt"] }
    }
  }
}
