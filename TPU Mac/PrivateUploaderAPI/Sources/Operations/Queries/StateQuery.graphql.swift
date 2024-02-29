// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class StateQuery: GraphQLQuery {
  public static let operationName: String = "StateQuery"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query StateQuery { coreState { __typename connection { __typename ip } name release hostname hostnameWithProtocol announcements { __typename userId content type id createdAt user { __typename username id avatar } } stats { __typename users announcements usage collections collectionItems uploads invites inviteMilestone pulse pulses docs messages chats hours } registrations commitVersion } }"#
    ))

  public init() {}

  public struct Data: PrivateUploaderAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { PrivateUploaderAPI.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("coreState", CoreState.self),
    ] }

    public var coreState: CoreState { __data["coreState"] }

    /// CoreState
    ///
    /// Parent Type: `CoreState`
    public struct CoreState: PrivateUploaderAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { PrivateUploaderAPI.Objects.CoreState }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("connection", Connection.self),
        .field("name", String.self),
        .field("release", String.self),
        .field("hostname", String.self),
        .field("hostnameWithProtocol", String.self),
        .field("announcements", [Announcement].self),
        .field("stats", Stats.self),
        .field("registrations", Bool.self),
        .field("commitVersion", String.self),
      ] }

      public var connection: Connection { __data["connection"] }
      public var name: String { __data["name"] }
      /// Whether the app is running in production mode.
      public var release: String { __data["release"] }
      public var hostname: String { __data["hostname"] }
      public var hostnameWithProtocol: String { __data["hostnameWithProtocol"] }
      public var announcements: [Announcement] { __data["announcements"] }
      public var stats: Stats { __data["stats"] }
      public var registrations: Bool { __data["registrations"] }
      public var commitVersion: String { __data["commitVersion"] }

      /// CoreState.Connection
      ///
      /// Parent Type: `Connection`
      public struct Connection: PrivateUploaderAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { PrivateUploaderAPI.Objects.Connection }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("ip", String.self),
        ] }

        public var ip: String { __data["ip"] }
      }

      /// CoreState.Announcement
      ///
      /// Parent Type: `Announcement`
      public struct Announcement: PrivateUploaderAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { PrivateUploaderAPI.Objects.Announcement }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("userId", Double.self),
          .field("content", String.self),
          .field("type", String?.self),
          .field("id", Int.self),
          .field("createdAt", PrivateUploaderAPI.Date?.self),
          .field("user", User.self),
        ] }

        public var userId: Double { __data["userId"] }
        public var content: String { __data["content"] }
        public var type: String? { __data["type"] }
        public var id: Int { __data["id"] }
        public var createdAt: PrivateUploaderAPI.Date? { __data["createdAt"] }
        public var user: User { __data["user"] }

        /// CoreState.Announcement.User
        ///
        /// Parent Type: `PartialUserBase`
        public struct User: PrivateUploaderAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { PrivateUploaderAPI.Objects.PartialUserBase }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("username", String.self),
            .field("id", Int.self),
            .field("avatar", String?.self),
          ] }

          public var username: String { __data["username"] }
          public var id: Int { __data["id"] }
          public var avatar: String? { __data["avatar"] }
        }
      }

      /// CoreState.Stats
      ///
      /// Parent Type: `CoreStats`
      public struct Stats: PrivateUploaderAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { PrivateUploaderAPI.Objects.CoreStats }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("users", Int.self),
          .field("announcements", Int.self),
          .field("usage", PrivateUploaderAPI.BigInt?.self),
          .field("collections", Int.self),
          .field("collectionItems", Int.self),
          .field("uploads", Int.self),
          .field("invites", Int.self),
          .field("inviteMilestone", Int.self),
          .field("pulse", Int.self),
          .field("pulses", Int.self),
          .field("docs", Int.self),
          .field("messages", Int.self),
          .field("chats", Int.self),
          .field("hours", PrivateUploaderAPI.JSON?.self),
        ] }

        public var users: Int { __data["users"] }
        public var announcements: Int { __data["announcements"] }
        public var usage: PrivateUploaderAPI.BigInt? { __data["usage"] }
        public var collections: Int { __data["collections"] }
        public var collectionItems: Int { __data["collectionItems"] }
        public var uploads: Int { __data["uploads"] }
        public var invites: Int { __data["invites"] }
        public var inviteMilestone: Int { __data["inviteMilestone"] }
        public var pulse: Int { __data["pulse"] }
        public var pulses: Int { __data["pulses"] }
        public var docs: Int { __data["docs"] }
        public var messages: Int { __data["messages"] }
        public var chats: Int { __data["chats"] }
        public var hours: PrivateUploaderAPI.JSON? { __data["hours"] }
      }
    }
  }
}
