// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class UpdateMessagesSubscription: GraphQLSubscription {
  public static let operationName: String = "UpdateMessages"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"subscription UpdateMessages { onMessage { __typename mention message { __typename ...StandardMessage } chat { __typename id recipient { __typename id username } type } } }"#,
      fragments: [StandardEmbed.self, StandardMessage.self]
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
          .fragment(StandardMessage.self),
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

        public struct Fragments: FragmentContainer {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public var standardMessage: StandardMessage { _toFragment() }
        }

        public typealias Emoji = StandardMessage.Emoji

        /// OnMessage.Message.Embed
        ///
        /// Parent Type: `EmbedDataV2`
        public struct Embed: PrivateUploaderAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { PrivateUploaderAPI.Objects.EmbedDataV2 }

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

        public typealias Reply = StandardMessage.Reply

        public typealias User = StandardMessage.User

        public typealias ReadReceipt = StandardMessage.ReadReceipt
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
