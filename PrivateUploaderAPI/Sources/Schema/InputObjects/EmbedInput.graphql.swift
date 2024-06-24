// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public struct EmbedInput: InputObject {
  public private(set) var __data: InputDict

  public init(_ data: InputDict) {
    __data = data
  }

  public init(
    url: GraphQLNullable<String> = nil,
    title: GraphQLNullable<String> = nil,
    description: GraphQLNullable<String> = nil,
    siteName: GraphQLNullable<String> = nil,
    type: GraphQLNullable<String> = nil,
    image: GraphQLNullable<String> = nil,
    color: GraphQLNullable<String> = nil,
    graph: GraphQLNullable<InteractiveGraphInput> = nil
  ) {
    __data = InputDict([
      "url": url,
      "title": title,
      "description": description,
      "siteName": siteName,
      "type": type,
      "image": image,
      "color": color,
      "graph": graph
    ])
  }

  public var url: GraphQLNullable<String> {
    get { __data["url"] }
    set { __data["url"] = newValue }
  }

  public var title: GraphQLNullable<String> {
    get { __data["title"] }
    set { __data["title"] = newValue }
  }

  public var description: GraphQLNullable<String> {
    get { __data["description"] }
    set { __data["description"] = newValue }
  }

  public var siteName: GraphQLNullable<String> {
    get { __data["siteName"] }
    set { __data["siteName"] = newValue }
  }

  public var type: GraphQLNullable<String> {
    get { __data["type"] }
    set { __data["type"] = newValue }
  }

  public var image: GraphQLNullable<String> {
    get { __data["image"] }
    set { __data["image"] = newValue }
  }

  public var color: GraphQLNullable<String> {
    get { __data["color"] }
    set { __data["color"] = newValue }
  }

  public var graph: GraphQLNullable<InteractiveGraphInput> {
    get { __data["graph"] }
    set { __data["graph"] = newValue }
  }
}
