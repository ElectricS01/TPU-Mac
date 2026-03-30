// @generated
// This file was automatically generated and should not be edited.

@_spi(Internal) @_spi(Unsafe) import ApolloAPI

public struct UserProfileInput: InputObject {
  @_spi(Unsafe) public private(set) var __data: InputDict

  @_spi(Unsafe) public init(_ data: InputDict) {
    __data = data
  }

  public init(
    id: GraphQLNullable<Int32> = nil,
    username: GraphQLNullable<String> = nil
  ) {
    __data = InputDict([
      "id": id,
      "username": username
    ])
  }

  public var id: GraphQLNullable<Int32> {
    get { __data["id"] }
    set { __data["id"] = newValue }
  }

  public var username: GraphQLNullable<String> {
    get { __data["username"] }
    set { __data["username"] = newValue }
  }
}
