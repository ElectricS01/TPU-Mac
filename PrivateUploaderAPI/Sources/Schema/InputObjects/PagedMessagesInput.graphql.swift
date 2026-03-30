// @generated
// This file was automatically generated and should not be edited.

@_spi(Internal) @_spi(Unsafe) import ApolloAPI

public struct PagedMessagesInput: InputObject {
  @_spi(Unsafe) public private(set) var __data: InputDict

  @_spi(Unsafe) public init(_ data: InputDict) {
    __data = data
  }

  public init(
    associationId: Int32,
    position: GraphQLNullable<GraphQLEnum<ScrollPosition>> = nil,
    search: GraphQLNullable<MessagesSearch> = nil,
    limit: Int32? = nil,
    page: Int32? = nil
  ) {
    __data = InputDict([
      "associationId": associationId,
      "position": position,
      "search": search,
      "limit": limit ?? GraphQLNullable.none,
      "page": page ?? GraphQLNullable.none
    ])
  }

  public var associationId: Int32 {
    get { __data["associationId"] }
    set { __data["associationId"] = newValue }
  }

  public var position: GraphQLNullable<GraphQLEnum<ScrollPosition>> {
    get { __data["position"] }
    set { __data["position"] = newValue }
  }

  public var search: GraphQLNullable<MessagesSearch> {
    get { __data["search"] }
    set { __data["search"] = newValue }
  }

  public var limit: Int32? {
    get { __data["limit"] }
    set { __data["limit"] = newValue }
  }

  public var page: Int32? {
    get { __data["page"] }
    set { __data["page"] = newValue }
  }
}
