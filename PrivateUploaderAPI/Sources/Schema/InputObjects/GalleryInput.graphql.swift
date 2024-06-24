// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public struct GalleryInput: InputObject {
  public private(set) var __data: InputDict

  public init(_ data: InputDict) {
    __data = data
  }

  public init(
    search: GraphQLNullable<String>,
    page: GraphQLNullable<Int>,
    limit: GraphQLNullable<Int> = nil,
    filters: GraphQLNullable<[GraphQLEnum<GalleryFilter>]>,
    sort: GraphQLNullable<GraphQLEnum<GallerySort>>,
    order: GraphQLNullable<GraphQLEnum<GalleryOrder>>,
    type: GraphQLNullable<GraphQLEnum<GalleryType>>,
    collectionId: GraphQLNullable<Int> = nil,
    shareLink: GraphQLNullable<String> = nil,
    advanced: GraphQLNullable<[SearchModeInput]> = nil
  ) {
    __data = InputDict([
      "search": search,
      "page": page,
      "limit": limit,
      "filters": filters,
      "sort": sort,
      "order": order,
      "type": type,
      "collectionId": collectionId,
      "shareLink": shareLink,
      "advanced": advanced
    ])
  }

  public var search: GraphQLNullable<String> {
    get { __data["search"] }
    set { __data["search"] = newValue }
  }

  public var page: GraphQLNullable<Int> {
    get { __data["page"] }
    set { __data["page"] = newValue }
  }

  public var limit: GraphQLNullable<Int> {
    get { __data["limit"] }
    set { __data["limit"] = newValue }
  }

  public var filters: GraphQLNullable<[GraphQLEnum<GalleryFilter>]> {
    get { __data["filters"] }
    set { __data["filters"] = newValue }
  }

  public var sort: GraphQLNullable<GraphQLEnum<GallerySort>> {
    get { __data["sort"] }
    set { __data["sort"] = newValue }
  }

  public var order: GraphQLNullable<GraphQLEnum<GalleryOrder>> {
    get { __data["order"] }
    set { __data["order"] = newValue }
  }

  public var type: GraphQLNullable<GraphQLEnum<GalleryType>> {
    get { __data["type"] }
    set { __data["type"] = newValue }
  }

  /// Requires Type to be COLLECTION
  public var collectionId: GraphQLNullable<Int> {
    get { __data["collectionId"] }
    set { __data["collectionId"] = newValue }
  }

  /// Requires Type to be COLLECTION
  public var shareLink: GraphQLNullable<String> {
    get { __data["shareLink"] }
    set { __data["shareLink"] = newValue }
  }

  public var advanced: GraphQLNullable<[SearchModeInput]> {
    get { __data["advanced"] }
    set { __data["advanced"] = newValue }
  }
}
