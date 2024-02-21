// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class ChatsQuery: GraphQLQuery {
  public static let operationName: String = "ChatsQuery"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query ChatsQuery { chats { __typename id type name unread icon association { __typename id chatId userId rank lastRead notifications legacyUserId user { __typename username id createdAt administrator moderator avatar } } users { __typename id chatId userId rank lastRead notifications legacyUserId user { __typename username id createdAt administrator moderator avatar } } _redisSortDate recipient { __typename username id createdAt administrator moderator avatar } } }"#
    ))

  public init() {}

  public struct Data: PrivateUploaderAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { PrivateUploaderAPI.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("chats", [Chat].self),
    ] }

    public var chats: [Chat] { __data["chats"] }

    /// Chat
    ///
    /// Parent Type: `Chat`
    public struct Chat: PrivateUploaderAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { PrivateUploaderAPI.Objects.Chat }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("id", Int.self),
        .field("type", String.self),
        .field("name", String.self),
        .field("unread", Int?.self),
        .field("icon", String?.self),
        .field("association", Association?.self),
        .field("users", [User].self),
        .field("_redisSortDate", String?.self),
        .field("recipient", Recipient?.self),
      ] }

      public var id: Int { __data["id"] }
      public var type: String { __data["type"] }
      public var name: String { __data["name"] }
      public var unread: Int? { __data["unread"] }
      public var icon: String? { __data["icon"] }
      public var association: Association? { __data["association"] }
      public var users: [User] { __data["users"] }
      public var _redisSortDate: String? { __data["_redisSortDate"] }
      public var recipient: Recipient? { __data["recipient"] }

      /// Chat.Association
      ///
      /// Parent Type: `ChatAssociation`
      public struct Association: PrivateUploaderAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { PrivateUploaderAPI.Objects.ChatAssociation }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("id", Int.self),
          .field("chatId", Int.self),
          .field("userId", Int?.self),
          .field("rank", String.self),
          .field("lastRead", Int?.self),
          .field("notifications", String.self),
          .field("legacyUserId", Int?.self),
          .field("user", User?.self),
        ] }

        public var id: Int { __data["id"] }
        public var chatId: Int { __data["chatId"] }
        public var userId: Int? { __data["userId"] }
        @available(*, deprecated, message: "`ChatRank` has replaced legacy rank for granular permission control.")
        public var rank: String { __data["rank"] }
        public var lastRead: Int? { __data["lastRead"] }
        public var notifications: String { __data["notifications"] }
        /// Used for legacy Colubrina accounts.
        @available(*, deprecated, message: "Use `userId` instead.")
        public var legacyUserId: Int? { __data["legacyUserId"] }
        public var user: User? { __data["user"] }

        /// Chat.Association.User
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
            .field("createdAt", PrivateUploaderAPI.Date.self),
            .field("administrator", Bool.self),
            .field("moderator", Bool.self),
            .field("avatar", String?.self),
          ] }

          public var username: String { __data["username"] }
          public var id: Int { __data["id"] }
          public var createdAt: PrivateUploaderAPI.Date { __data["createdAt"] }
          public var administrator: Bool { __data["administrator"] }
          public var moderator: Bool { __data["moderator"] }
          public var avatar: String? { __data["avatar"] }
        }
      }

      /// Chat.User
      ///
      /// Parent Type: `ChatAssociation`
      public struct User: PrivateUploaderAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { PrivateUploaderAPI.Objects.ChatAssociation }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("id", Int.self),
          .field("chatId", Int.self),
          .field("userId", Int?.self),
          .field("rank", String.self),
          .field("lastRead", Int?.self),
          .field("notifications", String.self),
          .field("legacyUserId", Int?.self),
          .field("user", User?.self),
        ] }

        public var id: Int { __data["id"] }
        public var chatId: Int { __data["chatId"] }
        public var userId: Int? { __data["userId"] }
        @available(*, deprecated, message: "`ChatRank` has replaced legacy rank for granular permission control.")
        public var rank: String { __data["rank"] }
        public var lastRead: Int? { __data["lastRead"] }
        public var notifications: String { __data["notifications"] }
        /// Used for legacy Colubrina accounts.
        @available(*, deprecated, message: "Use `userId` instead.")
        public var legacyUserId: Int? { __data["legacyUserId"] }
        public var user: User? { __data["user"] }

        /// Chat.User.User
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
            .field("createdAt", PrivateUploaderAPI.Date.self),
            .field("administrator", Bool.self),
            .field("moderator", Bool.self),
            .field("avatar", String?.self),
          ] }

          public var username: String { __data["username"] }
          public var id: Int { __data["id"] }
          public var createdAt: PrivateUploaderAPI.Date { __data["createdAt"] }
          public var administrator: Bool { __data["administrator"] }
          public var moderator: Bool { __data["moderator"] }
          public var avatar: String? { __data["avatar"] }
        }
      }

      /// Chat.Recipient
      ///
      /// Parent Type: `PartialUserBase`
      public struct Recipient: PrivateUploaderAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { PrivateUploaderAPI.Objects.PartialUserBase }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("username", String.self),
          .field("id", Int.self),
          .field("createdAt", PrivateUploaderAPI.Date.self),
          .field("administrator", Bool.self),
          .field("moderator", Bool.self),
          .field("avatar", String?.self),
        ] }

        public var username: String { __data["username"] }
        public var id: Int { __data["id"] }
        public var createdAt: PrivateUploaderAPI.Date { __data["createdAt"] }
        public var administrator: Bool { __data["administrator"] }
        public var moderator: Bool { __data["moderator"] }
        public var avatar: String? { __data["avatar"] }
      }
    }
  }
}
