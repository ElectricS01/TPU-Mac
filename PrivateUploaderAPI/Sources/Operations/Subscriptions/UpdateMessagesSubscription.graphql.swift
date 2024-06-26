// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class UpdateMessagesSubscription: GraphQLSubscription {
  public static let operationName: String = "UpdateMessages"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"subscription UpdateMessages { onMessage { __typename mention message { __typename id createdAt updatedAt chatId userId content type emoji { __typename name icon id chatId } embeds { __typename ...StandardEmbed } reply { __typename readReceipts { __typename user { __typename id avatar username legacy } } content userId id embeds { __typename media { __typename type } } user { __typename username id avatar } } user { __typename username id avatar } edited editedAt replyId pinned readReceipts { __typename user { __typename id avatar username legacy } } } chat { __typename id recipient { __typename id username } type } } }"#,
      fragments: [StandardEmbed.self]
    ))

  public init() {}

  public struct Data: PrivateUploaderAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { PrivateUploaderAPI.Objects.Subscription }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("onMessage", OnMessage.self),
    ] }

    public var onMessage: OnMessage { __data["onMessage"] }

    /// OnMessage
    ///
    /// Parent Type: `MessageSubscription`
    public struct OnMessage: PrivateUploaderAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { PrivateUploaderAPI.Objects.MessageSubscription }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("mention", Bool.self),
        .field("message", Message.self),
        .field("chat", Chat.self),
      ] }

      public var mention: Bool { __data["mention"] }
      public var message: Message { __data["message"] }
      public var chat: Chat { __data["chat"] }

      /// OnMessage.Message
      ///
      /// Parent Type: `Message`
      public struct Message: PrivateUploaderAPI.SelectionSet {
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
          .field("user", User?.self),
          .field("edited", Bool.self),
          .field("editedAt", PrivateUploaderAPI.Date?.self),
          .field("replyId", Int?.self),
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
        public var user: User? { __data["user"] }
        public var edited: Bool { __data["edited"] }
        public var editedAt: PrivateUploaderAPI.Date? { __data["editedAt"] }
        public var replyId: Int? { __data["replyId"] }
        public var pinned: Bool { __data["pinned"] }
        public var readReceipts: [ReadReceipt] { __data["readReceipts"] }

        /// OnMessage.Message.Emoji
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

        /// OnMessage.Message.Embed
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

          public struct Fragments: FragmentContainer {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public var standardEmbed: StandardEmbed { _toFragment() }
          }

          public typealias Medium = StandardEmbed.Medium

          public typealias Text = StandardEmbed.Text
        }

        /// OnMessage.Message.Reply
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
            .field("embeds", [Embed].self),
            .field("user", User?.self),
          ] }

          public var readReceipts: [ReadReceipt] { __data["readReceipts"] }
          public var content: String? { __data["content"] }
          public var userId: Int? { __data["userId"] }
          public var id: Int { __data["id"] }
          public var embeds: [Embed] { __data["embeds"] }
          public var user: User? { __data["user"] }

          /// OnMessage.Message.Reply.ReadReceipt
          ///
          /// Parent Type: `ReadReceipt`
          public struct ReadReceipt: PrivateUploaderAPI.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: ApolloAPI.ParentType { PrivateUploaderAPI.Objects.ReadReceipt }
            public static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .field("user", User?.self),
            ] }

            public var user: User? { __data["user"] }

            /// OnMessage.Message.Reply.ReadReceipt.User
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

          /// OnMessage.Message.Reply.Embed
          ///
          /// Parent Type: `EmbedDataV2`
          public struct Embed: PrivateUploaderAPI.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: ApolloAPI.ParentType { PrivateUploaderAPI.Objects.EmbedDataV2 }
            public static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .field("media", [Medium]?.self),
            ] }

            public var media: [Medium]? { __data["media"] }

            /// OnMessage.Message.Reply.Embed.Medium
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

          /// OnMessage.Message.Reply.User
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

        /// OnMessage.Message.User
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

        /// OnMessage.Message.ReadReceipt
        ///
        /// Parent Type: `ReadReceipt`
        public struct ReadReceipt: PrivateUploaderAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { PrivateUploaderAPI.Objects.ReadReceipt }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("user", User?.self),
          ] }

          public var user: User? { __data["user"] }

          /// OnMessage.Message.ReadReceipt.User
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

      /// OnMessage.Chat
      ///
      /// Parent Type: `Chat`
      public struct Chat: PrivateUploaderAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { PrivateUploaderAPI.Objects.Chat }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("id", Int.self),
          .field("recipient", Recipient?.self),
          .field("type", String.self),
        ] }

        public var id: Int { __data["id"] }
        public var recipient: Recipient? { __data["recipient"] }
        public var type: String { __data["type"] }

        /// OnMessage.Chat.Recipient
        ///
        /// Parent Type: `PartialUserBase`
        public struct Recipient: PrivateUploaderAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { PrivateUploaderAPI.Objects.PartialUserBase }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("id", Int.self),
            .field("username", String.self),
          ] }

          public var id: Int { __data["id"] }
          public var username: String { __data["username"] }
        }
      }
    }
  }
}
