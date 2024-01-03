// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class MessagesQuery: GraphQLQuery {
  public static let operationName: String = "Messages"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query Messages($input: InfiniteMessagesInput!) { messages(input: $input) { __typename ...StandardMessage } }"#,
      fragments: [StandardMessage.self, StandardEmbed.self]
    ))

  public var input: InfiniteMessagesInput

  public init(input: InfiniteMessagesInput) {
    self.input = input
  }

  public var __variables: Variables? { ["input": input] }

  public struct Data: PrivateUploaderAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { PrivateUploaderAPI.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("messages", [Message].self, arguments: ["input": .variable("input")]),
    ] }

    public var messages: [Message] { __data["messages"] }

    /// Message
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
      public var type: GraphQLEnum<PrivateUploaderAPI.MessageType>? { __data["type"] }
      public var emoji: [StandardMessage.Emoji]? { __data["emoji"] }
      public var embeds: [Embed] { __data["embeds"] }
      public var reply: StandardMessage.Reply? { __data["reply"] }
      public var legacyUser: StandardMessage.LegacyUser? { __data["legacyUser"] }
      public var user: StandardMessage.User? { __data["user"] }
      public var edited: Bool { __data["edited"] }
      public var editedAt: PrivateUploaderAPI.Date? { __data["editedAt"] }
      public var replyId: Int? { __data["replyId"] }
      public var legacyUserId: Int? { __data["legacyUserId"] }
      public var pinned: Bool { __data["pinned"] }
      public var readReceipts: [StandardMessage.ReadReceipt] { __data["readReceipts"] }

      public struct Fragments: FragmentContainer {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public var standardMessage: StandardMessage { _toFragment() }
      }

      /// Message.Embed
      ///
      /// Parent Type: `EmbedDataV2`
      public struct Embed: PrivateUploaderAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { PrivateUploaderAPI.Objects.EmbedDataV2 }

        public var media: [StandardEmbed.Medium]? { __data["media"] }
        public var text: [StandardEmbed.Text]? { __data["text"] }
        public var metadata: StandardEmbed.Metadata { __data["metadata"] }

        public struct Fragments: FragmentContainer {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public var standardEmbed: StandardEmbed { _toFragment() }
        }
      }
    }
  }
}
