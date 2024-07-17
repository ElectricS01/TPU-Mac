// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class DeleteMessageMutation: GraphQLMutation {
  public static let operationName: String = "DeleteMessage"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation DeleteMessage($input: DeleteMessageInput!) { deleteMessage(input: $input) }"#
    ))

  public var input: DeleteMessageInput

  public init(input: DeleteMessageInput) {
    self.input = input
  }

  public var __variables: Variables? { ["input": input] }

  public struct Data: PrivateUploaderAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { PrivateUploaderAPI.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("deleteMessage", Bool.self, arguments: ["input": .variable("input")]),
    ] }

    public var deleteMessage: Bool { __data["deleteMessage"] }
  }
}
