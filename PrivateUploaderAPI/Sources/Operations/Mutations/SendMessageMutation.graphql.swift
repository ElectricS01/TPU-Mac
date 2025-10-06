// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class SendMessageMutation: GraphQLMutation {
  public static let operationName: String = "SendMessage"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation SendMessage($input: SendMessageInput!) { sendMessage(input: $input) { __typename id } }"#
    ))

  public var input: SendMessageInput

  public init(input: SendMessageInput) {
    self.input = input
  }

  public var __variables: Variables? { ["input": input] }

  public struct Data: PrivateUploaderAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { PrivateUploaderAPI.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("sendMessage", SendMessage.self, arguments: ["input": .variable("input")]),
    ] }

    public var sendMessage: SendMessage { __data["sendMessage"] }

    /// SendMessage
    ///
    /// Parent Type: `Message`
    public struct SendMessage: PrivateUploaderAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: any ApolloAPI.ParentType { PrivateUploaderAPI.Objects.Message }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("id", Int.self),
      ] }

      public var id: Int { __data["id"] }
    }
  }
}
