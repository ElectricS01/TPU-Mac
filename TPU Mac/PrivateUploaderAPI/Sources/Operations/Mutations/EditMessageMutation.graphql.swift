// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class EditMessageMutation: GraphQLMutation {
  public static let operationName: String = "EditMessage"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation EditMessage($input: EditMessageInput!) { editMessage(input: $input) { __typename id } }"#
    ))

  public var input: EditMessageInput

  public init(input: EditMessageInput) {
    self.input = input
  }

  public var __variables: Variables? { ["input": input] }

  public struct Data: PrivateUploaderAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { PrivateUploaderAPI.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("editMessage", EditMessage?.self, arguments: ["input": .variable("input")]),
    ] }

    public var editMessage: EditMessage? { __data["editMessage"] }

    /// EditMessage
    ///
    /// Parent Type: `Message`
    public struct EditMessage: PrivateUploaderAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { PrivateUploaderAPI.Objects.Message }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("id", Int.self),
      ] }

      public var id: Int { __data["id"] }
    }
  }
}
