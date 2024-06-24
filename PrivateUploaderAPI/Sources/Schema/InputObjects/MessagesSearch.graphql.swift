// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public struct MessagesSearch: InputObject {
  public private(set) var __data: InputDict

  public init(_ data: InputDict) {
    __data = data
  }

  public init(
    query: GraphQLNullable<String> = nil,
    userId: GraphQLNullable<Int> = nil,
    before: GraphQLNullable<Date> = nil,
    after: GraphQLNullable<Date> = nil,
    pins: GraphQLNullable<Bool> = nil
  ) {
    __data = InputDict([
      "query": query,
      "userId": userId,
      "before": before,
      "after": after,
      "pins": pins
    ])
  }

  public var query: GraphQLNullable<String> {
    get { __data["query"] }
    set { __data["query"] = newValue }
  }

  public var userId: GraphQLNullable<Int> {
    get { __data["userId"] }
    set { __data["userId"] = newValue }
  }

  public var before: GraphQLNullable<Date> {
    get { __data["before"] }
    set { __data["before"] = newValue }
  }

  public var after: GraphQLNullable<Date> {
    get { __data["after"] }
    set { __data["after"] = newValue }
  }

  public var pins: GraphQLNullable<Bool> {
    get { __data["pins"] }
    set { __data["pins"] = newValue }
  }
}
