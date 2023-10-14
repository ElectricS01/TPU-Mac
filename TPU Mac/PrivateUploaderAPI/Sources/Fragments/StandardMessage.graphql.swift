// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public struct StandardMessage: PrivateUploaderAPI.SelectionSet, Fragment {
  public static var fragmentDefinition: StaticString {
    #"fragment StandardMessage on Message { __typename id createdAt updatedAt chatId userId content type emoji { __typename name icon id chatId } embeds { __typename type data } reply { __typename readReceipts { __typename id userId lastRead legacyUserId } content userId id legacyUserId embeds { __typename type } legacyUser { __typename username id avatar } user { __typename username id avatar } } legacyUser { __typename username id avatar } user { __typename username id avatar } edited editedAt replyId legacyUserId pinned readReceipts { __typename id userId lastRead legacyUserId } }"#
  }

  public let __data: DataDict
  public init(_dataDict: DataDict) { __data = _dataDict }

  public static var __parentType: ApolloAPI.ParentType { PrivateUploaderAPI.Objects.Message }
  public static var __selections: [ApolloAPI.Selection] { [
    .field("__typename", String.self),
    .field("id", Int.self),
    .field("createdAt", PrivateUploaderAPI.Date.self),
    .field("updatedAt", PrivateUploaderAPI.Date.self),
    .field("chatId", Int.self),
    .field("userId", Int?.self),
    .field("content", String?.self),
    .field("type", GraphQLEnum<PrivateUploaderAPI.MessageType>?.self),
    .field("emoji", [Emoji]?.self),
    .field("embeds", [Embed].self),
    .field("reply", Reply?.self),
    .field("legacyUser", LegacyUser?.self),
    .field("user", User?.self),
    .field("edited", Bool.self),
    .field("editedAt", PrivateUploaderAPI.Date?.self),
    .field("replyId", Int?.self),
    .field("legacyUserId", Int?.self),
    .field("pinned", Bool.self),
    .field("readReceipts", [ReadReceipt].self),
  ] }

  public var id: Int { __data["id"] }
  public var createdAt: PrivateUploaderAPI.Date { __data["createdAt"] }
  public var updatedAt: PrivateUploaderAPI.Date { __data["updatedAt"] }
  public var chatId: Int { __data["chatId"] }
  public var userId: Int? { __data["userId"] }
  public var content: String? { __data["content"] }
  public var type: GraphQLEnum<PrivateUploaderAPI.MessageType>? { __data["type"] }
  public var emoji: [Emoji]? { __data["emoji"] }
  public var embeds: [Embed] { __data["embeds"] }
  public var reply: Reply? { __data["reply"] }
  public var legacyUser: LegacyUser? { __data["legacyUser"] }
  public var user: User? { __data["user"] }
  public var edited: Bool { __data["edited"] }
  public var editedAt: PrivateUploaderAPI.Date? { __data["editedAt"] }
  public var replyId: Int? { __data["replyId"] }
  public var legacyUserId: Int? { __data["legacyUserId"] }
  public var pinned: Bool { __data["pinned"] }
  public var readReceipts: [ReadReceipt] { __data["readReceipts"] }

  /// Emoji
  ///
  /// Parent Type: `ChatEmoji`
  public struct Emoji: PrivateUploaderAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { PrivateUploaderAPI.Objects.ChatEmoji }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("__typename", String.self),
      .field("name", String?.self),
      .field("icon", String?.self),
      .field("id", String.self),
      .field("chatId", Int.self),
    ] }

    public var name: String? { __data["name"] }
    public var icon: String? { __data["icon"] }
    public var id: String { __data["id"] }
    public var chatId: Int { __data["chatId"] }
  }

  /// Embed
  ///
  /// Parent Type: `Embed`
  public struct Embed: PrivateUploaderAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { PrivateUploaderAPI.Objects.Embed }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("__typename", String.self),
      .field("type", String.self),
      .field("data", PrivateUploaderAPI.JSON?.self),
    ] }

    public var type: String { __data["type"] }
    public var data: PrivateUploaderAPI.JSON? { __data["data"] }
  }

  /// Reply
  ///
  /// Parent Type: `Message`
  public struct Reply: PrivateUploaderAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { PrivateUploaderAPI.Objects.Message }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("__typename", String.self),
      .field("readReceipts", [ReadReceipt].self),
      .field("content", String?.self),
      .field("userId", Int?.self),
      .field("id", Int.self),
      .field("legacyUserId", Int?.self),
      .field("embeds", [Embed].self),
      .field("legacyUser", LegacyUser?.self),
      .field("user", User?.self),
    ] }

    public var readReceipts: [ReadReceipt] { __data["readReceipts"] }
    public var content: String? { __data["content"] }
    public var userId: Int? { __data["userId"] }
    public var id: Int { __data["id"] }
    public var legacyUserId: Int? { __data["legacyUserId"] }
    public var embeds: [Embed] { __data["embeds"] }
    public var legacyUser: LegacyUser? { __data["legacyUser"] }
    public var user: User? { __data["user"] }

    /// Reply.ReadReceipt
    ///
    /// Parent Type: `ChatAssociation`
    public struct ReadReceipt: PrivateUploaderAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { PrivateUploaderAPI.Objects.ChatAssociation }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("id", Int.self),
        .field("userId", Double?.self),
        .field("lastRead", Double?.self),
        .field("legacyUserId", Double?.self),
      ] }

      public var id: Int { __data["id"] }
      public var userId: Double? { __data["userId"] }
      public var lastRead: Double? { __data["lastRead"] }
      /// Used for legacy Colubrina accounts.
      @available(*, deprecated, message: "Use `userId` instead.")
      public var legacyUserId: Double? { __data["legacyUserId"] }
    }

    /// Reply.Embed
    ///
    /// Parent Type: `Embed`
    public struct Embed: PrivateUploaderAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { PrivateUploaderAPI.Objects.Embed }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("type", String.self),
      ] }

      public var type: String { __data["type"] }
    }

    /// Reply.LegacyUser
    ///
    /// Parent Type: `PartialUserBase`
    public struct LegacyUser: PrivateUploaderAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { PrivateUploaderAPI.Objects.PartialUserBase }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("username", String.self),
        .field("id", Double.self),
        .field("avatar", String?.self),
      ] }

      public var username: String { __data["username"] }
      public var id: Double { __data["id"] }
      public var avatar: String? { __data["avatar"] }
    }

    /// Reply.User
    ///
    /// Parent Type: `PartialUserBase`
    public struct User: PrivateUploaderAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { PrivateUploaderAPI.Objects.PartialUserBase }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("username", String.self),
        .field("id", Double.self),
        .field("avatar", String?.self),
      ] }

      public var username: String { __data["username"] }
      public var id: Double { __data["id"] }
      public var avatar: String? { __data["avatar"] }
    }
  }

  /// LegacyUser
  ///
  /// Parent Type: `PartialUserBase`
  public struct LegacyUser: PrivateUploaderAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { PrivateUploaderAPI.Objects.PartialUserBase }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("__typename", String.self),
      .field("username", String.self),
      .field("id", Double.self),
      .field("avatar", String?.self),
    ] }

    public var username: String { __data["username"] }
    public var id: Double { __data["id"] }
    public var avatar: String? { __data["avatar"] }
  }

  /// User
  ///
  /// Parent Type: `PartialUserBase`
  public struct User: PrivateUploaderAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { PrivateUploaderAPI.Objects.PartialUserBase }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("__typename", String.self),
      .field("username", String.self),
      .field("id", Double.self),
      .field("avatar", String?.self),
    ] }

    public var username: String { __data["username"] }
    public var id: Double { __data["id"] }
    public var avatar: String? { __data["avatar"] }
  }

  /// ReadReceipt
  ///
  /// Parent Type: `ChatAssociation`
  public struct ReadReceipt: PrivateUploaderAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { PrivateUploaderAPI.Objects.ChatAssociation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("__typename", String.self),
      .field("id", Int.self),
      .field("userId", Double?.self),
      .field("lastRead", Double?.self),
      .field("legacyUserId", Double?.self),
    ] }

    public var id: Int { __data["id"] }
    public var userId: Double? { __data["userId"] }
    public var lastRead: Double? { __data["lastRead"] }
    /// Used for legacy Colubrina accounts.
    @available(*, deprecated, message: "Use `userId` instead.")
    public var legacyUserId: Double? { __data["legacyUserId"] }
  }
}
