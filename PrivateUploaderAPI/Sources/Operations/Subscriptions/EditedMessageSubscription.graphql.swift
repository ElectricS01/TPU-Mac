// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class EditedMessageSubscription: GraphQLSubscription {
  public static let operationName: String = "EditedMessage"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"subscription EditedMessage { onEditMessage { __typename message { __typename content userId pending error edited id pinned editedAt embeds { __typename ...StandardEmbed } emoji { __typename id chatId name icon } } } }"#,
      fragments: [StandardEmbed.self]
    ))

  public init() {}

  public struct Data: PrivateUploaderAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { PrivateUploaderAPI.Objects.Subscription }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("onEditMessage", OnEditMessage.self),
    ] }

    public var onEditMessage: OnEditMessage { __data["onEditMessage"] }

    /// OnEditMessage
    ///
    /// Parent Type: `EditMessageEvent`
    public struct OnEditMessage: PrivateUploaderAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { PrivateUploaderAPI.Objects.EditMessageEvent }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("message", Message.self),
      ] }

      public var message: Message { __data["message"] }

      /// OnEditMessage.Message
      ///
      /// Parent Type: `Message`
      public struct Message: PrivateUploaderAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { PrivateUploaderAPI.Objects.Message }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("content", String?.self),
          .field("userId", Int?.self),
          .field("pending", Bool.self),
          .field("error", Bool.self),
          .field("edited", Bool.self),
          .field("id", Int.self),
          .field("pinned", Bool.self),
          .field("editedAt", PrivateUploaderAPI.Date?.self),
          .field("embeds", [Embed].self),
          .field("emoji", [Emoji]?.self),
        ] }

        public var content: String? { __data["content"] }
        public var userId: Int? { __data["userId"] }
        public var pending: Bool { __data["pending"] }
        public var error: Bool { __data["error"] }
        public var edited: Bool { __data["edited"] }
        public var id: Int { __data["id"] }
        public var pinned: Bool { __data["pinned"] }
        public var editedAt: PrivateUploaderAPI.Date? { __data["editedAt"] }
        public var embeds: [Embed] { __data["embeds"] }
        public var emoji: [Emoji]? { __data["emoji"] }

        /// OnEditMessage.Message.Embed
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

        /// OnEditMessage.Message.Emoji
        ///
        /// Parent Type: `ChatEmoji`
        public struct Emoji: PrivateUploaderAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { PrivateUploaderAPI.Objects.ChatEmoji }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("id", String.self),
            .field("chatId", Int.self),
            .field("name", String?.self),
            .field("icon", String?.self),
          ] }

          public var id: String { __data["id"] }
          public var chatId: Int { __data["chatId"] }
          public var name: String? { __data["name"] }
          public var icon: String? { __data["icon"] }
        }
      }
    }
  }
}
