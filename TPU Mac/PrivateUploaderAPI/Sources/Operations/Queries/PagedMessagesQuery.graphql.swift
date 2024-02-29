// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class PagedMessagesQuery: GraphQLQuery {
  public static let operationName: String = "PagedMessages"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query PagedMessages($input: PagedMessagesInput!) { messagesPaged(input: $input) { __typename items { __typename ...StandardMessage } pager { __typename ...PagerFragment } } }"#,
      fragments: [PagerFragment.self, StandardEmbed.self, StandardMessage.self]
    ))

  public var input: PagedMessagesInput

  public init(input: PagedMessagesInput) {
    self.input = input
  }

  public var __variables: Variables? { ["input": input] }

  public struct Data: PrivateUploaderAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { PrivateUploaderAPI.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("messagesPaged", MessagesPaged.self, arguments: ["input": .variable("input")]),
    ] }

    public var messagesPaged: MessagesPaged { __data["messagesPaged"] }

    /// MessagesPaged
    ///
    /// Parent Type: `PaginatedMessageResponse`
    public struct MessagesPaged: PrivateUploaderAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { PrivateUploaderAPI.Objects.PaginatedMessageResponse }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("items", [Item].self),
        .field("pager", Pager.self),
      ] }

      public var items: [Item] { __data["items"] }
      public var pager: Pager { __data["pager"] }

      /// MessagesPaged.Item
      ///
      /// Parent Type: `Message`
      public struct Item: PrivateUploaderAPI.SelectionSet {
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

        public struct Fragments: FragmentContainer {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public var standardMessage: StandardMessage { _toFragment() }
        }

        public typealias Emoji = StandardMessage.Emoji

        /// MessagesPaged.Item.Embed
        ///
        /// Parent Type: `EmbedDataV2`
        public struct Embed: PrivateUploaderAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { PrivateUploaderAPI.Objects.EmbedDataV2 }

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

        public typealias Reply = StandardMessage.Reply

        public typealias LegacyUser = StandardMessage.LegacyUser

        public typealias User = StandardMessage.User

        public typealias ReadReceipt = StandardMessage.ReadReceipt
      }

      /// MessagesPaged.Pager
      ///
      /// Parent Type: `Pager`
      public struct Pager: PrivateUploaderAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { PrivateUploaderAPI.Objects.Pager }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .fragment(PagerFragment.self),
        ] }

        public var totalItems: Int { __data["totalItems"] }
        public var currentPage: Int { __data["currentPage"] }
        public var pageSize: Int { __data["pageSize"] }
        public var totalPages: Int { __data["totalPages"] }
        public var startPage: Int { __data["startPage"] }
        public var endPage: Int { __data["endPage"] }
        public var startIndex: Int { __data["startIndex"] }
        public var endIndex: Int { __data["endIndex"] }
        public var pages: [Double] { __data["pages"] }

        public struct Fragments: FragmentContainer {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public var pagerFragment: PagerFragment { _toFragment() }
        }
      }
    }
  }
}
