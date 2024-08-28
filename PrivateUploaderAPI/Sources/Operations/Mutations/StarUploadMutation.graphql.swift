// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class StarUploadMutation: GraphQLMutation {
  public static let operationName: String = "StarUpload"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation StarUpload($input: StarUploadInput!) { starUpload(input: $input) { __typename star { __typename id } } }"#
    ))

  public var input: StarUploadInput

  public init(input: StarUploadInput) {
    self.input = input
  }

  public var __variables: Variables? { ["input": input] }

  public struct Data: PrivateUploaderAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { PrivateUploaderAPI.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("starUpload", StarUpload.self, arguments: ["input": .variable("input")]),
    ] }

    public var starUpload: StarUpload { __data["starUpload"] }

    /// StarUpload
    ///
    /// Parent Type: `StarUploadResponse`
    public struct StarUpload: PrivateUploaderAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { PrivateUploaderAPI.Objects.StarUploadResponse }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("star", Star?.self),
      ] }

      public var star: Star? { __data["star"] }

      /// StarUpload.Star
      ///
      /// Parent Type: `Star`
      public struct Star: PrivateUploaderAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { PrivateUploaderAPI.Objects.Star }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("id", Int.self),
        ] }

        public var id: Int { __data["id"] }
      }
    }
  }
}
