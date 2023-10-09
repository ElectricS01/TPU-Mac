// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class GalleryQuery: GraphQLQuery {
  public static let operationName: String = "Gallery"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query Gallery($input: GalleryInput!) { gallery(input: $input) { __typename pager { __typename totalItems currentPage pageSize totalPages startPage endPage startIndex endIndex } items { __typename autoCollectApproval { __typename id autoCollectRuleId } id createdAt updatedAt attachment userId name originalFilename type fileSize deletable textMetadata user { __typename username id avatar } collections { __typename id name } item { __typename id pinned } starred { __typename id userId attachmentId } } } }"#
    ))

  public var input: GalleryInput

  public init(input: GalleryInput) {
    self.input = input
  }

  public var __variables: Variables? { ["input": input] }

  public struct Data: PrivateUploaderAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { PrivateUploaderAPI.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("gallery", Gallery.self, arguments: ["input": .variable("input")]),
    ] }

    public var gallery: Gallery { __data["gallery"] }

    /// Gallery
    ///
    /// Parent Type: `PaginatedUploadResponse`
    public struct Gallery: PrivateUploaderAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { PrivateUploaderAPI.Objects.PaginatedUploadResponse }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("pager", Pager.self),
        .field("items", [Item].self),
      ] }

      public var pager: Pager { __data["pager"] }
      public var items: [Item] { __data["items"] }

      /// Gallery.Pager
      ///
      /// Parent Type: `Pager`
      public struct Pager: PrivateUploaderAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { PrivateUploaderAPI.Objects.Pager }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("totalItems", Int.self),
          .field("currentPage", Int.self),
          .field("pageSize", Int.self),
          .field("totalPages", Int.self),
          .field("startPage", Int.self),
          .field("endPage", Int.self),
          .field("startIndex", Int.self),
          .field("endIndex", Int.self),
        ] }

        public var totalItems: Int { __data["totalItems"] }
        public var currentPage: Int { __data["currentPage"] }
        public var pageSize: Int { __data["pageSize"] }
        public var totalPages: Int { __data["totalPages"] }
        public var startPage: Int { __data["startPage"] }
        public var endPage: Int { __data["endPage"] }
        public var startIndex: Int { __data["startIndex"] }
        public var endIndex: Int { __data["endIndex"] }
      }

      /// Gallery.Item
      ///
      /// Parent Type: `Upload`
      public struct Item: PrivateUploaderAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { PrivateUploaderAPI.Objects.Upload }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("autoCollectApproval", AutoCollectApproval?.self),
          .field("id", Int.self),
          .field("createdAt", PrivateUploaderAPI.Date.self),
          .field("updatedAt", PrivateUploaderAPI.Date.self),
          .field("attachment", String.self),
          .field("userId", Double.self),
          .field("name", String?.self),
          .field("originalFilename", String?.self),
          .field("type", String.self),
          .field("fileSize", Double.self),
          .field("deletable", Bool.self),
          .field("textMetadata", String?.self),
          .field("user", User?.self),
          .field("collections", [Collection].self),
          .field("item", Item?.self),
          .field("starred", Starred?.self),
        ] }

        public var autoCollectApproval: AutoCollectApproval? { __data["autoCollectApproval"] }
        public var id: Int { __data["id"] }
        public var createdAt: PrivateUploaderAPI.Date { __data["createdAt"] }
        public var updatedAt: PrivateUploaderAPI.Date { __data["updatedAt"] }
        public var attachment: String { __data["attachment"] }
        public var userId: Double { __data["userId"] }
        public var name: String? { __data["name"] }
        public var originalFilename: String? { __data["originalFilename"] }
        public var type: String { __data["type"] }
        public var fileSize: Double { __data["fileSize"] }
        /// Non-deletable items are used for profile pictures, banners, etc and are not visible in the Gallery page.
        public var deletable: Bool { __data["deletable"] }
        /// This is used for OCR scanned text from images.
        public var textMetadata: String? { __data["textMetadata"] }
        public var user: User? { __data["user"] }
        public var collections: [Collection] { __data["collections"] }
        public var item: Item? { __data["item"] }
        public var starred: Starred? { __data["starred"] }

        /// Gallery.Item.AutoCollectApproval
        ///
        /// Parent Type: `AutoCollectApproval`
        public struct AutoCollectApproval: PrivateUploaderAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { PrivateUploaderAPI.Objects.AutoCollectApproval }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("id", Int.self),
            .field("autoCollectRuleId", Double.self),
          ] }

          public var id: Int { __data["id"] }
          public var autoCollectRuleId: Double { __data["autoCollectRuleId"] }
        }

        /// Gallery.Item.User
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

        /// Gallery.Item.Collection
        ///
        /// Parent Type: `Collection`
        public struct Collection: PrivateUploaderAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { PrivateUploaderAPI.Objects.Collection }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("id", Int.self),
            .field("name", String.self),
          ] }

          public var id: Int { __data["id"] }
          public var name: String { __data["name"] }
        }

        /// Gallery.Item.Item
        ///
        /// Parent Type: `CollectionItem`
        public struct Item: PrivateUploaderAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { PrivateUploaderAPI.Objects.CollectionItem }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("id", Int.self),
            .field("pinned", Bool.self),
          ] }

          public var id: Int { __data["id"] }
          public var pinned: Bool { __data["pinned"] }
        }

        /// Gallery.Item.Starred
        ///
        /// Parent Type: `Star`
        public struct Starred: PrivateUploaderAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { PrivateUploaderAPI.Objects.Star }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("id", Int.self),
            .field("userId", Double.self),
            .field("attachmentId", Double.self),
          ] }

          public var id: Int { __data["id"] }
          public var userId: Double { __data["userId"] }
          public var attachmentId: Double { __data["attachmentId"] }
        }
      }
    }
  }
}
