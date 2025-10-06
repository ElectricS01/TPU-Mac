// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class DeleteUploadsMutation: GraphQLMutation {
  public static let operationName: String = "DeleteUploads"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation DeleteUploads($input: DeleteUploadInput!) { deleteUploads(input: $input) { __typename success } }"#
    ))

  public var input: DeleteUploadInput

  public init(input: DeleteUploadInput) {
    self.input = input
  }

  public var __variables: Variables? { ["input": input] }

  public struct Data: PrivateUploaderAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { PrivateUploaderAPI.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("deleteUploads", DeleteUploads.self, arguments: ["input": .variable("input")]),
    ] }

    public var deleteUploads: DeleteUploads { __data["deleteUploads"] }

    /// DeleteUploads
    ///
    /// Parent Type: `GenericSuccessObject`
    public struct DeleteUploads: PrivateUploaderAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: any ApolloAPI.ParentType { PrivateUploaderAPI.Objects.GenericSuccessObject }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("success", Bool.self),
      ] }

      public var success: Bool { __data["success"] }
    }
  }
}
