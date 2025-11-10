// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class UpdateUserMutation: GraphQLMutation {
  public static let operationName: String = "UpdateUser"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation UpdateUser($input: UpdateUserInput!) { updateUser(input: $input) }"#
    ))

  public var input: UpdateUserInput

  public init(input: UpdateUserInput) {
    self.input = input
  }

  public var __variables: Variables? { ["input": input] }

  public struct Data: PrivateUploaderAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { PrivateUploaderAPI.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("updateUser", Bool.self, arguments: ["input": .variable("input")]),
    ] }
    public static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
      UpdateUserMutation.Data.self
    ] }

    public var updateUser: Bool { __data["updateUser"] }
  }
}
