// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class FriendMutation: GraphQLMutation {
  public static let operationName: String = "Friend"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation Friend($input: AddFriendInput!) { friend(input: $input) }"#
    ))

  public var input: AddFriendInput

  public init(input: AddFriendInput) {
    self.input = input
  }

  public var __variables: Variables? { ["input": input] }

  public struct Data: PrivateUploaderAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { PrivateUploaderAPI.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("friend", Bool.self, arguments: ["input": .variable("input")]),
    ] }
    public static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
      FriendMutation.Data.self
    ] }

    public var friend: Bool { __data["friend"] }
  }
}
