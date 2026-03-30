// @generated
// This file was automatically generated and should not be edited.

@_spi(Internal) @_spi(Unsafe) import ApolloAPI

public struct UserCollectionsInput: InputObject {
  @_spi(Unsafe) public private(set) var __data: InputDict

  @_spi(Unsafe) public init(_ data: InputDict) {
    __data = data
  }

  public init(
    filter: [GraphQLEnum<CollectionFilter>]? = nil,
    search: GraphQLNullable<String> = nil,
    limit: GraphQLNullable<Int32> = nil,
    page: Int32? = nil,
    onlyInvited: Bool? = nil
  ) {
    __data = InputDict([
      "filter": filter ?? GraphQLNullable.none,
      "search": search,
      "limit": limit,
      "page": page ?? GraphQLNullable.none,
      "onlyInvited": onlyInvited ?? GraphQLNullable.none
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

  public var limit: GraphQLNullable<Int32> {
    get { __data["limit"] }
    set { __data["limit"] = newValue }
  }

  public var page: Int32? {
    get { __data["page"] }
    set { __data["page"] = newValue }
  }

  public var onlyInvited: Bool? {
    get { __data["onlyInvited"] }
    set { __data["onlyInvited"] = newValue }
  }
}
