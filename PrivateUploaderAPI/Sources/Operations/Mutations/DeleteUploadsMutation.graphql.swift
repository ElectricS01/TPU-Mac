// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI
@_spi(Execution) @_spi(Unsafe) import ApolloAPI

public struct DeleteUploadsMutation: GraphQLMutation {
  public static let operationName: String = "DeleteUploads"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation DeleteUploads($input: DeleteUploadInput!) { deleteUploads(input: $input) { __typename success } }"#
    ))

  public var input: DeleteUploadInput

  public init(input: DeleteUploadInput) {
    self.input = input
  }

  @_spi(Unsafe) public var __variables: Variables? { ["input": input] }

  public struct Data: PrivateUploaderAPI.SelectionSet {
    @_spi(Unsafe) public let __data: DataDict
    @_spi(Unsafe) public init(_dataDict: DataDict) { __data = _dataDict }

    @_spi(Execution) public static var __parentType: any ApolloAPI.ParentType { PrivateUploaderAPI.Objects.Mutation }
    @_spi(Execution) public static var __selections: [ApolloAPI.Selection] { [
      .field("deleteUploads", DeleteUploads.self, arguments: ["input": .variable("input")]),
    ] }
    @_spi(Execution) public static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
      DeleteUploadsMutation.Data.self
    ] }

    public var deleteUploads: DeleteUploads { __data["deleteUploads"] }

    /// DeleteUploads
    ///
    /// Parent Type: `GenericSuccessObject`
    public struct DeleteUploads: PrivateUploaderAPI.SelectionSet {
      @_spi(Unsafe) public let __data: DataDict
      @_spi(Unsafe) public init(_dataDict: DataDict) { __data = _dataDict }

      @_spi(Execution) public static var __parentType: any ApolloAPI.ParentType { PrivateUploaderAPI.Objects.GenericSuccessObject }
      @_spi(Execution) public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("success", Bool.self),
      ] }
      @_spi(Execution) public static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
        DeleteUploadsMutation.Data.DeleteUploads.self
      ] }

      public var success: Bool { __data["success"] }
    }
  }
}
