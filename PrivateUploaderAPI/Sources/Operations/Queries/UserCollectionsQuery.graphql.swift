// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class UserCollectionsQuery: GraphQLQuery {
  public static let operationName: String = "UserCollectionsQuery"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query UserCollectionsQuery($input: UserCollectionsInput!) { collections(input: $input) { __typename items { __typename id name banner userId shareLink createdAt user { __typename username id avatar } preview { __typename attachment { __typename attachment id } } shared itemCount permissionsMetadata { __typename write read configure } } pager { __typename totalItems totalPages } } }"#
    ))

  public var input: UserCollectionsInput

  public init(input: UserCollectionsInput) {
    self.input = input
  }

  public var __variables: Variables? { ["input": input] }

  public struct Data: PrivateUploaderAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { PrivateUploaderAPI.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("collections", Collections.self, arguments: ["input": .variable("input")]),
    ] }

    public var collections: Collections { __data["collections"] }

    /// Collections
    ///
    /// Parent Type: `PaginatedCollectionResponse`
    public struct Collections: PrivateUploaderAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { PrivateUploaderAPI.Objects.PaginatedCollectionResponse }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("items", [Item].self),
        .field("pager", Pager.self),
      ] }

      public var items: [Item] { __data["items"] }
      public var pager: Pager { __data["pager"] }

      /// Collections.Item
      ///
      /// Parent Type: `Collection`
      public struct Item: PrivateUploaderAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { PrivateUploaderAPI.Objects.Collection }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("id", Int.self),
          .field("name", String.self),
          .field("banner", String?.self),
          .field("userId", Double.self),
          .field("shareLink", String?.self),
          .field("createdAt", PrivateUploaderAPI.Date.self),
          .field("user", User?.self),
          .field("preview", Preview?.self),
          .field("shared", Bool?.self),
          .field("itemCount", Int?.self),
          .field("permissionsMetadata", PermissionsMetadata.self),
        ] }

        public var id: Int { __data["id"] }
        public var name: String { __data["name"] }
        /// The recommended way to obtain the banner for a collection, it uses field `image`, and if null, falls back to the last added image preview.
        public var banner: String? { __data["banner"] }
        public var userId: Double { __data["userId"] }
        public var shareLink: String? { __data["shareLink"] }
        public var createdAt: PrivateUploaderAPI.Date { __data["createdAt"] }
        public var user: User? { __data["user"] }
        public var preview: Preview? { __data["preview"] }
        public var shared: Bool? { __data["shared"] }
        public var itemCount: Int? { __data["itemCount"] }
        public var permissionsMetadata: PermissionsMetadata { __data["permissionsMetadata"] }

        /// Collections.Item.User
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

        /// Collections.Item.Preview
        ///
        /// Parent Type: `CollectionItem`
        public struct Preview: PrivateUploaderAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { PrivateUploaderAPI.Objects.CollectionItem }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("attachment", Attachment.self),
          ] }

          public var attachment: Attachment { __data["attachment"] }

          /// Collections.Item.Preview.Attachment
          ///
          /// Parent Type: `Upload`
          public struct Attachment: PrivateUploaderAPI.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: ApolloAPI.ParentType { PrivateUploaderAPI.Objects.Upload }
            public static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .field("attachment", String.self),
              .field("id", Int.self),
            ] }

            public var attachment: String { __data["attachment"] }
            public var id: Int { __data["id"] }
          }
        }

        /// Collections.Item.PermissionsMetadata
        ///
        /// Parent Type: `PermissionsMetadata`
        public struct PermissionsMetadata: PrivateUploaderAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { PrivateUploaderAPI.Objects.PermissionsMetadata }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("write", Bool.self),
            .field("read", Bool.self),
            .field("configure", Bool.self),
          ] }

          public var write: Bool { __data["write"] }
          public var read: Bool { __data["read"] }
          public var configure: Bool { __data["configure"] }
        }
      }

      /// Collections.Pager
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
        ] }

        public var totalItems: Int { __data["totalItems"] }
        public var totalPages: Int { __data["totalPages"] }
      }
    }
  }
}
