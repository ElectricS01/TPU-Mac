// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class GalleryItemsQuery: GraphQLQuery {
  public static let operationName: String = "GalleryItems"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query GalleryItems($input: GalleryInput!) { gallery(input: $input) { __typename pager { __typename totalItems totalPages endPage } items { __typename id attachment type fileSize name textMetadata createdAt } } }"#
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
          .field("totalPages", Int.self),
          .field("endPage", Int.self),
        ] }

        public var totalItems: Int { __data["totalItems"] }
        public var totalPages: Int { __data["totalPages"] }
        public var endPage: Int { __data["endPage"] }
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
          .field("id", Int.self),
          .field("attachment", String.self),
          .field("type", String.self),
          .field("fileSize", Double.self),
          .field("name", String?.self),
          .field("textMetadata", String?.self),
          .field("createdAt", PrivateUploaderAPI.Date.self),
        ] }

        public var id: Int { __data["id"] }
        public var attachment: String { __data["attachment"] }
        public var type: String { __data["type"] }
        public var fileSize: Double { __data["fileSize"] }
        public var name: String? { __data["name"] }
        /// This is used for OCR scanned text from images.
        public var textMetadata: String? { __data["textMetadata"] }
        public var createdAt: PrivateUploaderAPI.Date { __data["createdAt"] }
      }
    }
  }
}
