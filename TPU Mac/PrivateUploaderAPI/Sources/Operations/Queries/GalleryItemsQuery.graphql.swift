// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class GalleryItemsQuery: GraphQLQuery {
  public static let operationName: String = "GalleryItems"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query GalleryItems($input: GalleryInput!) { gallery(input: $input) { __typename items { __typename id attachment name textMetadata } } }"#
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
        .field("items", [Item].self),
      ] }

      public var items: [Item] { __data["items"] }

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
          .field("name", String?.self),
          .field("textMetadata", String?.self),
        ] }

        public var id: Int { __data["id"] }
        public var attachment: String { __data["attachment"] }
        public var name: String? { __data["name"] }
        /// This is used for OCR scanned text from images.
        public var textMetadata: String? { __data["textMetadata"] }
      }
    }
  }
}
