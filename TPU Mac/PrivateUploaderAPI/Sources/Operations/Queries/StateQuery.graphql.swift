// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class StateQuery: GraphQLQuery {
  public static let operationName: String = "StateQuery"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query StateQuery { coreState { __typename announcements { __typename userId content type id createdAt user { __typename username id avatar } } stats { __typename users collections collectionItems uploads messages chats } } currentUser { __typename username description administrator emailVerified banned createdAt avatar moderator banner status storedStatus privacyPolicyAccepted domain { __typename active domain id } badges { __typename color icon id image name priority tooltip } id notifications { __typename id dismissed message route createdAt } } }"#
    ))

  public init() {}

  public struct Data: PrivateUploaderAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { PrivateUploaderAPI.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("coreState", CoreState.self),
      .field("currentUser", CurrentUser?.self),
    ] }

    public var coreState: CoreState { __data["coreState"] }
    public var currentUser: CurrentUser? { __data["currentUser"] }

    /// CoreState
    ///
    /// Parent Type: `CoreState`
    public struct CoreState: PrivateUploaderAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { PrivateUploaderAPI.Objects.CoreState }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("announcements", [Announcement].self),
        .field("stats", Stats.self),
      ] }

      public var announcements: [Announcement] { __data["announcements"] }
      public var stats: Stats { __data["stats"] }

      /// CoreState.Announcement
      ///
      /// Parent Type: `Announcement`
      public struct Announcement: PrivateUploaderAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { PrivateUploaderAPI.Objects.Announcement }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("userId", Double?.self),
          .field("content", String.self),
          .field("type", String?.self),
          .field("id", Int.self),
          .field("createdAt", PrivateUploaderAPI.Date?.self),
          .field("user", User?.self),
        ] }

        public var userId: Double? { __data["userId"] }
        public var content: String { __data["content"] }
        public var type: String? { __data["type"] }
        public var id: Int { __data["id"] }
        public var createdAt: PrivateUploaderAPI.Date? { __data["createdAt"] }
        public var user: User? { __data["user"] }

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
          .field("collections", Int.self),
          .field("collectionItems", Int.self),
          .field("uploads", Int.self),
          .field("messages", Int.self),
          .field("chats", Int.self),
        ] }

        public var users: Int { __data["users"] }
        public var collections: Int { __data["collections"] }
        public var collectionItems: Int { __data["collectionItems"] }
        public var uploads: Int { __data["uploads"] }
        public var messages: Int { __data["messages"] }
        public var chats: Int { __data["chats"] }
      }
    }

    /// CurrentUser
    ///
    /// Parent Type: `User`
    public struct CurrentUser: PrivateUploaderAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { PrivateUploaderAPI.Objects.User }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("username", String.self),
        .field("description", String?.self),
        .field("administrator", Bool.self),
        .field("emailVerified", Bool.self),
        .field("banned", Bool.self),
        .field("createdAt", PrivateUploaderAPI.Date.self),
        .field("avatar", String?.self),
        .field("moderator", Bool.self),
        .field("banner", String?.self),
        .field("status", GraphQLEnum<PrivateUploaderAPI.UserStatus>.self),
        .field("storedStatus", GraphQLEnum<PrivateUploaderAPI.UserStoredStatus>.self),
        .field("privacyPolicyAccepted", Bool?.self),
        .field("domain", Domain?.self),
        .field("badges", [Badge].self),
        .field("id", Int.self),
        .field("notifications", [Notification].self),
      ] }

      public var username: String { __data["username"] }
      public var description: String? { __data["description"] }
      public var administrator: Bool { __data["administrator"] }
      public var emailVerified: Bool { __data["emailVerified"] }
      public var banned: Bool { __data["banned"] }
      public var createdAt: PrivateUploaderAPI.Date { __data["createdAt"] }
      public var avatar: String? { __data["avatar"] }
      public var moderator: Bool { __data["moderator"] }
      /// UserV2 banner.
      public var banner: String? { __data["banner"] }
      /// User status/presence shown to other users.
      public var status: GraphQLEnum<PrivateUploaderAPI.UserStatus> { __data["status"] }
      /// User status/presence that has `invisible` and is shown to the current user.
      public var storedStatus: GraphQLEnum<PrivateUploaderAPI.UserStoredStatus> { __data["storedStatus"] }
      public var privacyPolicyAccepted: Bool? { __data["privacyPolicyAccepted"] }
      public var domain: Domain? { __data["domain"] }
      public var badges: [Badge] { __data["badges"] }
      public var id: Int { __data["id"] }
      public var notifications: [Notification] { __data["notifications"] }

      /// CurrentUser.Domain
      ///
      /// Parent Type: `Domain`
      public struct Domain: PrivateUploaderAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { PrivateUploaderAPI.Objects.Domain }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("active", Bool.self),
          .field("domain", String.self),
          .field("id", Int.self),
        ] }

        public var active: Bool { __data["active"] }
        public var domain: String { __data["domain"] }
        public var id: Int { __data["id"] }
      }

      /// CurrentUser.Badge
      ///
      /// Parent Type: `Badge`
      public struct Badge: PrivateUploaderAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { PrivateUploaderAPI.Objects.Badge }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("color", String?.self),
          .field("icon", String?.self),
          .field("id", Int.self),
          .field("image", String?.self),
          .field("name", String.self),
          .field("priority", Double?.self),
          .field("tooltip", String?.self),
        ] }

        public var color: String? { __data["color"] }
        public var icon: String? { __data["icon"] }
        public var id: Int { __data["id"] }
        public var image: String? { __data["image"] }
        public var name: String { __data["name"] }
        public var priority: Double? { __data["priority"] }
        public var tooltip: String? { __data["tooltip"] }
      }

      /// CurrentUser.Notification
      ///
      /// Parent Type: `Notification`
      public struct Notification: PrivateUploaderAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { PrivateUploaderAPI.Objects.Notification }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("id", Int.self),
          .field("dismissed", Bool.self),
          .field("message", String.self),
          .field("route", String?.self),
          .field("createdAt", PrivateUploaderAPI.Date.self),
        ] }

        public var id: Int { __data["id"] }
        public var dismissed: Bool { __data["dismissed"] }
        public var message: String { __data["message"] }
        public var route: String? { __data["route"] }
        public var createdAt: PrivateUploaderAPI.Date { __data["createdAt"] }
      }
    }
  }
}
