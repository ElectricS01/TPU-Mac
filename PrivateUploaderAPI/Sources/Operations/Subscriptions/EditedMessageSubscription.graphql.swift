// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class EditedMessageSubscription: GraphQLSubscription {
  public static let operationName: String = "EditedMessage"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"subscription EditedMessage { onEditMessage { __typename associationId message { __typename ...StandardMessage } } }"#,
      fragments: [StandardEmbed.self, StandardMessage.self]
    ))

  public init() {}

  public struct Data: PrivateUploaderAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { PrivateUploaderAPI.Objects.Subscription }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("onEditMessage", OnEditMessage.self),
    ] }
    public static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
      EditedMessageSubscription.Data.self
    ] }

    public var onEditMessage: OnEditMessage { __data["onEditMessage"] }

    /// OnEditMessage
    ///
    /// Parent Type: `EditMessageEvent`
    public struct OnEditMessage: PrivateUploaderAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: any ApolloAPI.ParentType { PrivateUploaderAPI.Objects.EditMessageEvent }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("associationId", Int.self),
        .field("message", Message.self),
      ] }
      public static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
        EditedMessageSubscription.Data.OnEditMessage.self
      ] }

      public var associationId: Int { __data["associationId"] }
      public var message: Message { __data["message"] }

      /// OnEditMessage.Message
      ///
      /// Parent Type: `Message`
      public struct Message: PrivateUploaderAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: any ApolloAPI.ParentType { PrivateUploaderAPI.Objects.Message }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .fragment(StandardMessage.self),
        ] }
        public static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
          EditedMessageSubscription.Data.OnEditMessage.Message.self,
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

        public struct Fragments: FragmentContainer {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public var standardMessage: StandardMessage { _toFragment() }
        }

        public typealias Emoji = StandardMessage.Emoji

        public typealias Embed = StandardMessage.Embed

        public typealias Reply = StandardMessage.Reply

        public typealias User = StandardMessage.User

        public typealias ReadReceipt = StandardMessage.ReadReceipt
      }
    }
  }
}
