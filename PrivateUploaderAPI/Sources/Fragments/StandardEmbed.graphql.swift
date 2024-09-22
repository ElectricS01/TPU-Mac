// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public struct StandardEmbed: PrivateUploaderAPI.SelectionSet, Fragment {
  public static var fragmentDefinition: StaticString {
    #"fragment StandardEmbed on EmbedDataV2 { __typename media { __typename url proxyUrl attachment width height isInternal videoEmbedUrl upload { __typename id createdAt attachment userId name type fileSize } mimeType type } text { __typename imageProxyUrl text heading imageUrl } }"#
  }

  public let __data: DataDict
  public init(_dataDict: DataDict) { __data = _dataDict }

  public static var __parentType: ApolloAPI.ParentType { PrivateUploaderAPI.Objects.EmbedDataV2 }
  public static var __selections: [ApolloAPI.Selection] { [
    .field("__typename", String.self),
    .field("media", [Medium]?.self),
    .field("text", [Text]?.self),
  ] }

  public var media: [Medium]? { __data["media"] }
  public var text: [Text]? { __data["text"] }

  /// Medium
  ///
  /// Parent Type: `EmbedMedia`
  public struct Medium: PrivateUploaderAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { PrivateUploaderAPI.Objects.EmbedMedia }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("__typename", String.self),
      .field("url", String?.self),
      .field("proxyUrl", String?.self),
      .field("attachment", String?.self),
      .field("width", Int?.self),
      .field("height", Int?.self),
      .field("isInternal", Bool.self),
      .field("videoEmbedUrl", String?.self),
      .field("upload", Upload?.self),
      .field("mimeType", String?.self),
      .field("type", GraphQLEnum<PrivateUploaderAPI.EmbedMediaType>.self),
    ] }

    public var url: String? { __data["url"] }
    public var proxyUrl: String? { __data["proxyUrl"] }
    public var attachment: String? { __data["attachment"] }
    public var width: Int? { __data["width"] }
    public var height: Int? { __data["height"] }
    public var isInternal: Bool { __data["isInternal"] }
    /// Used for trusted video embed sources, such as YouTube.
    public var videoEmbedUrl: String? { __data["videoEmbedUrl"] }
    public var upload: Upload? { __data["upload"] }
    public var mimeType: String? { __data["mimeType"] }
    public var type: GraphQLEnum<PrivateUploaderAPI.EmbedMediaType> { __data["type"] }

    /// Medium.Upload
    ///
    /// Parent Type: `Upload`
    public struct Upload: PrivateUploaderAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { PrivateUploaderAPI.Objects.Upload }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("id", Int.self),
        .field("createdAt", PrivateUploaderAPI.Date.self),
        .field("attachment", String.self),
        .field("userId", Int.self),
        .field("name", String?.self),
        .field("type", String.self),
        .field("fileSize", Double.self),
      ] }

      public var id: Int { __data["id"] }
      public var createdAt: PrivateUploaderAPI.Date { __data["createdAt"] }
      public var attachment: String { __data["attachment"] }
      public var userId: Int { __data["userId"] }
      public var name: String? { __data["name"] }
      public var type: String { __data["type"] }
      public var fileSize: Double { __data["fileSize"] }
    }
  }

  /// Text
  ///
  /// Parent Type: `EmbedText`
  public struct Text: PrivateUploaderAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { PrivateUploaderAPI.Objects.EmbedText }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("__typename", String.self),
      .field("imageProxyUrl", String?.self),
      .field("text", String.self),
      .field("heading", Bool?.self),
      .field("imageUrl", String?.self),
    ] }

    public var imageProxyUrl: String? { __data["imageProxyUrl"] }
    public var text: String { __data["text"] }
    public var heading: Bool? { __data["heading"] }
    public var imageUrl: String? { __data["imageUrl"] }
  }
}
