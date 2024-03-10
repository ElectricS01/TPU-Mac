// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public struct StandardMessage: PrivateUploaderAPI.SelectionSet, Fragment {
  public static var fragmentDefinition: StaticString {
    #"fragment StandardMessage on Message { __typename id createdAt updatedAt chatId userId content type emoji { __typename name icon id chatId } embeds { __typename ...StandardEmbed } reply { __typename readReceipts { __typename associationId user { __typename id avatar username legacy } messageId } content userId id legacyUserId embeds { __typename metadata { __typename type } media { __typename type } } legacyUser { __typename username id avatar } user { __typename username id avatar } } legacyUser { __typename username id avatar } user { __typename username id avatar } edited editedAt replyId legacyUserId pinned readReceipts { __typename associationId user { __typename id avatar username legacy } messageId } }"#
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
  /// Parent Type: `EmbedDataV2`
  public struct Embed: PrivateUploaderAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { PrivateUploaderAPI.Objects.EmbedDataV2 }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("__typename", String.self),
      .fragment(StandardEmbed.self),
    ] }

    public var media: [Medium]? { __data["media"] }
    public var text: [Text]? { __data["text"] }
    public var metadata: Metadata { __data["metadata"] }

    public struct Fragments: FragmentContainer {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public var standardEmbed: StandardEmbed { _toFragment() }
    }

    public typealias Medium = StandardEmbed.Medium

    public typealias Text = StandardEmbed.Text

    public typealias Metadata = StandardEmbed.Metadata
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
    /// Parent Type: `ReadReceipt`
    public struct ReadReceipt: PrivateUploaderAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { PrivateUploaderAPI.Objects.ReadReceipt }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("associationId", Int.self),
        .field("user", User?.self),
        .field("messageId", Int.self),
      ] }

      public var associationId: Int { __data["associationId"] }
      public var user: User? { __data["user"] }
      public var messageId: Int { __data["messageId"] }

      /// Reply.ReadReceipt.User
      ///
      /// Parent Type: `PartialUserBase`
      public struct User: PrivateUploaderAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { PrivateUploaderAPI.Objects.PartialUserBase }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("id", Int.self),
          .field("avatar", String?.self),
          .field("username", String.self),
          .field("legacy", Bool.self),
        ] }

        public var id: Int { __data["id"] }
        public var avatar: String? { __data["avatar"] }
        public var username: String { __data["username"] }
        public var legacy: Bool { __data["legacy"] }
      }
    }

    /// Reply.Embed
    ///
    /// Parent Type: `EmbedDataV2`
    public struct Embed: PrivateUploaderAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { PrivateUploaderAPI.Objects.EmbedDataV2 }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("metadata", Metadata.self),
        .field("media", [Medium]?.self),
      ] }

      public var metadata: Metadata { __data["metadata"] }
      public var media: [Medium]? { __data["media"] }

      /// Reply.Embed.Metadata
      ///
      /// Parent Type: `EmbedMetadata`
      public struct Metadata: PrivateUploaderAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { PrivateUploaderAPI.Objects.EmbedMetadata }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("type", Double.self),
        ] }

        public var type: Double { __data["type"] }
      }

      /// Reply.Embed.Medium
      ///
      /// Parent Type: `EmbedMedia`
      public struct Medium: PrivateUploaderAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { PrivateUploaderAPI.Objects.EmbedMedia }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("type", GraphQLEnum<PrivateUploaderAPI.EmbedMediaType>.self),
        ] }

        public var type: GraphQLEnum<PrivateUploaderAPI.EmbedMediaType> { __data["type"] }
      }
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
        .field("id", Int.self),
        .field("avatar", String?.self),
      ] }

      public var username: String { __data["username"] }
      public var id: Int { __data["id"] }
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
        .field("id", Int.self),
        .field("avatar", String?.self),
      ] }

      public var username: String { __data["username"] }
      public var id: Int { __data["id"] }
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
      .field("id", Int.self),
      .field("avatar", String?.self),
    ] }

    public var username: String { __data["username"] }
    public var id: Int { __data["id"] }
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
      .field("id", Int.self),
      .field("avatar", String?.self),
    ] }

    public var username: String { __data["username"] }
    public var id: Int { __data["id"] }
    public var avatar: String? { __data["avatar"] }
  }

  /// ReadReceipt
  ///
  /// Parent Type: `ReadReceipt`
  public struct ReadReceipt: PrivateUploaderAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { PrivateUploaderAPI.Objects.ReadReceipt }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("__typename", String.self),
      .field("associationId", Int.self),
      .field("user", User?.self),
      .field("messageId", Int.self),
    ] }

    public var associationId: Int { __data["associationId"] }
    public var user: User? { __data["user"] }
    public var messageId: Int { __data["messageId"] }

    /// ReadReceipt.User
    ///
    /// Parent Type: `PartialUserBase`
    public struct User: PrivateUploaderAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { PrivateUploaderAPI.Objects.PartialUserBase }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("id", Int.self),
        .field("avatar", String?.self),
        .field("username", String.self),
        .field("legacy", Bool.self),
      ] }

      public var id: Int { __data["id"] }
      public var avatar: String? { __data["avatar"] }
      public var username: String { __data["username"] }
      public var legacy: Bool { __data["legacy"] }
    }
  }
}
