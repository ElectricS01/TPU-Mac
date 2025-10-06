// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public struct UserCollectionsInput: InputObject {
  public private(set) var __data: InputDict

  public init(_ data: InputDict) {
    __data = data
  }

  public init(
    filter: [GraphQLEnum<CollectionFilter>]? = nil,
    search: GraphQLNullable<String> = nil,
    limit: GraphQLNullable<Int> = nil,
    page: Int? = nil,
    onlyInvited: Bool? = nil
  ) {
    __data = InputDict([
      "filter": filter,
      "search": search,
      "limit": limit,
      "page": page,
      "onlyInvited": onlyInvited
    ])
  }

  public var filter: [GraphQLEnum<CollectionFilter>]? {
    get { __data["filter"] }
    set { __data["filter"] = newValue }
  }

  public var search: GraphQLNullable<String> {
    get { __data["search"] }
    set { __data["search"] = newValue }
  }

  public var limit: GraphQLNullable<Int> {
    get { __data["limit"] }
    set { __data["limit"] = newValue }
  }

  public var page: Int? {
    get { __data["page"] }
    set { __data["page"] = newValue }
  }

  public var onlyInvited: Bool? {
    get { __data["onlyInvited"] }
    set { __data["onlyInvited"] = newValue }
  }
}
