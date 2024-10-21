// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class DeletedMessageSubscription: GraphQLSubscription {
  public static let operationName: String = "DeletedMessage"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"subscription DeletedMessage { onDeleteMessage { __typename id associationId } }"#
    ))

  public init() {}

  public struct Data: PrivateUploaderAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { PrivateUploaderAPI.Objects.Subscription }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("onDeleteMessage", OnDeleteMessage.self),
    ] }

    public var onDeleteMessage: OnDeleteMessage { __data["onDeleteMessage"] }

    /// OnDeleteMessage
    ///
    /// Parent Type: `DeleteMessage`
    public struct OnDeleteMessage: PrivateUploaderAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { PrivateUploaderAPI.Objects.DeleteMessage }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("id", Int.self),
        .field("associationId", Int.self),
      ] }

      public var id: Int { __data["id"] }
      public var associationId: Int { __data["associationId"] }
    }
  }
}
