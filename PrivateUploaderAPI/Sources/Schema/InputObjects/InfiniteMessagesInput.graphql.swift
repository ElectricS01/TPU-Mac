// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public struct InfiniteMessagesInput: InputObject {
  public private(set) var __data: InputDict

  public init(_ data: InputDict) {
    __data = data
  }

  public init(
    associationId: Int,
    position: GraphQLNullable<GraphQLEnum<ScrollPosition>> = nil,
    search: GraphQLNullable<MessagesSearch> = nil,
    limit: Int? = nil,
    offset: GraphQLNullable<Int> = nil
  ) {
    __data = InputDict([
      "associationId": associationId,
      "position": position,
      "search": search,
      "limit": limit,
      "offset": offset
    ])
  }

  public var associationId: Int {
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

  public var limit: Int? {
    get { __data["limit"] }
    set { __data["limit"] = newValue }
  }

  public var offset: GraphQLNullable<Int> {
    get { __data["offset"] }
    set { __data["offset"] = newValue }
  }
}
