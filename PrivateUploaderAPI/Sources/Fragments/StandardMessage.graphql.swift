// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public struct StandardMessage: PrivateUploaderAPI.SelectionSet, Fragment {
  public static var fragmentDefinition: StaticString {
    #"fragment StandardMessage on Message { __typename id createdAt updatedAt chatId userId content type emoji { __typename name icon id chatId } embeds { __typename ...StandardEmbed } reply { __typename content userId id embeds { __typename media { __typename type } } user { __typename username id avatar } } user { __typename username id avatar } edited editedAt replyId pinned readReceipts { __typename user { __typename id avatar username } } }"#
  }

  public let __data: DataDict
  public init(_dataDict: DataDict) { __data = _dataDict }

  public static var __parentType: any ApolloAPI.ParentType { PrivateUploaderAPI.Objects.Message }
  public static var __selections: [ApolloAPI.Selection] { [
    .field("__typename", String.self),
    .field("id", Int.self),
    .field("createdAt", PrivateUploaderAPI.Date.self),
    .field("updatedAt", PrivateUploaderAPI.Date.self),
    .field("chatId", Int.self),
    .field("userId", Int?.self),
    .field("content", String?.self),
    .field("type", GraphQLEnum<PrivateUploaderAPI.MessageType>.self),
    .field("emoji", [Emoji]?.self),
    .field("embeds", [Embed].self),
    .field("reply", Reply?.self),
    .field("user", User?.self),
    .field("edited", Bool.self),
    .field("editedAt", PrivateUploaderAPI.Date?.self),
    .field("replyId", Int?.self),
    .field("pinned", Bool.self),
    .field("readReceipts", [ReadReceipt].self),
  ] }
  public static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
    StandardMessage.self
  ] }

  public var id: Int { __data["id"] }
  public var createdAt: PrivateUploaderAPI.Date { __data["createdAt"] }
  public var updatedAt: PrivateUploaderAPI.Date { __data["updatedAt"] }
  public var chatId: Int { __data["chatId"] }
  public var userId: Int? { __data["userId"] }
  public var content: String? { __data["content"] }
  public var type: GraphQLEnum<PrivateUploaderAPI.MessageType> { __data["type"] }
  public var emoji: [Emoji]? { __data["emoji"] }
  public var embeds: [Embed] { __data["embeds"] }
  public var reply: Reply? { __data["reply"] }
  public var user: User? { __data["user"] }
  public var edited: Bool { __data["edited"] }
  public var editedAt: PrivateUploaderAPI.Date? { __data["editedAt"] }
  public var replyId: Int? { __data["replyId"] }
  public var pinned: Bool { __data["pinned"] }
  public var readReceipts: [ReadReceipt] { __data["readReceipts"] }

  /// Emoji
  ///
  /// Parent Type: `ChatEmoji`
  public struct Emoji: PrivateUploaderAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { PrivateUploaderAPI.Objects.ChatEmoji }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("__typename", String.self),
      .field("name", String?.self),
      .field("icon", String?.self),
      .field("id", String.self),
      .field("chatId", Int.self),
    ] }
    public static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
      StandardMessage.Emoji.self
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

    public static var __parentType: any ApolloAPI.ParentType { PrivateUploaderAPI.Objects.EmbedDataV2 }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("__typename", String.self),
      .fragment(StandardEmbed.self),
    ] }
    public static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
      StandardMessage.Embed.self,
      StandardEmbed.self
    ] }

    public var media: [Medium]? { __data["media"] }
    public var text: [Text]? { __data["text"] }

    public struct Fragments: FragmentContainer {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public var standardEmbed: StandardEmbed { _toFragment() }
    }

    public typealias Medium = StandardEmbed.Medium

    public typealias Text = StandardEmbed.Text
  }

  /// Reply
  ///
  /// Parent Type: `Message`
  public struct Reply: PrivateUploaderAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { PrivateUploaderAPI.Objects.Message }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("__typename", String.self),
      .field("content", String?.self),
      .field("userId", Int?.self),
      .field("id", Int.self),
      .field("embeds", [Embed].self),
      .field("user", User?.self),
    ] }
    public static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
      StandardMessage.Reply.self
    ] }

    public var content: String? { __data["content"] }
    public var userId: Int? { __data["userId"] }
    public var id: Int { __data["id"] }
    public var embeds: [Embed] { __data["embeds"] }
    public var user: User? { __data["user"] }

    /// Reply.Embed
    ///
    /// Parent Type: `EmbedDataV2`
    public struct Embed: PrivateUploaderAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: any ApolloAPI.ParentType { PrivateUploaderAPI.Objects.EmbedDataV2 }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("media", [Medium]?.self),
      ] }
      public static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
        StandardMessage.Reply.Embed.self
      ] }

      public var media: [Medium]? { __data["media"] }

      /// Reply.Embed.Medium
      ///
      /// Parent Type: `EmbedMedia`
      public struct Medium: PrivateUploaderAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: any ApolloAPI.ParentType { PrivateUploaderAPI.Objects.EmbedMedia }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("type", GraphQLEnum<PrivateUploaderAPI.EmbedMediaType>.self),
        ] }
        public static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
          StandardMessage.Reply.Embed.Medium.self
        ] }

        public var type: GraphQLEnum<PrivateUploaderAPI.EmbedMediaType> { __data["type"] }
      }
    }

    /// Reply.User
    ///
    /// Parent Type: `PartialUserBase`
    public struct User: PrivateUploaderAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: any ApolloAPI.ParentType { PrivateUploaderAPI.Objects.PartialUserBase }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("username", String.self),
        .field("id", Int.self),
        .field("avatar", String?.self),
      ] }
      public static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
        StandardMessage.Reply.User.self
      ] }

      public var username: String { __data["username"] }
      public var id: Int { __data["id"] }
      public var avatar: String? { __data["avatar"] }
    }
  }

  /// User
  ///
  /// Parent Type: `PartialUserBase`
  public struct User: PrivateUploaderAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { PrivateUploaderAPI.Objects.PartialUserBase }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("__typename", String.self),
      .field("username", String.self),
      .field("id", Int.self),
      .field("avatar", String?.self),
    ] }
    public static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
      StandardMessage.User.self
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

    public static var __parentType: any ApolloAPI.ParentType { PrivateUploaderAPI.Objects.ReadReceipt }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("__typename", String.self),
      .field("user", User?.self),
    ] }
    public static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
      StandardMessage.ReadReceipt.self
    ] }

    public var user: User? { __data["user"] }

    /// ReadReceipt.User
    ///
    /// Parent Type: `PartialUserBase`
    public struct User: PrivateUploaderAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: any ApolloAPI.ParentType { PrivateUploaderAPI.Objects.PartialUserBase }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("id", Int.self),
        .field("avatar", String?.self),
        .field("username", String.self),
      ] }
      public static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
        StandardMessage.ReadReceipt.User.self
      ] }

      public var id: Int { __data["id"] }
      public var avatar: String? { __data["avatar"] }
      public var username: String { __data["username"] }
    }
  }
}
