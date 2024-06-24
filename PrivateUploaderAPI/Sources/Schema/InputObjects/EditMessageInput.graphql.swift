// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public struct EditMessageInput: InputObject {
  public private(set) var __data: InputDict

  public init(_ data: InputDict) {
    __data = data
  }

  public init(
    content: GraphQLNullable<String> = nil,
    attachments: [String]?,
    messageId: Int,
    embeds: GraphQLNullable<[EmbedInput]> = nil,
    associationId: Int,
    pinned: GraphQLNullable<Bool> = nil
  ) {
    __data = InputDict([
      "content": content,
      "attachments": attachments,
      "messageId": messageId,
      "embeds": embeds,
      "associationId": associationId,
      "pinned": pinned
    ])
  }

  public var content: GraphQLNullable<String> {
    get { __data["content"] }
    set { __data["content"] = newValue }
  }

  public var attachments: [String]? {
    get { __data["attachments"] }
    set { __data["attachments"] = newValue }
  }

  public var messageId: Int {
    get { __data["messageId"] }
    set { __data["messageId"] = newValue }
  }

  public var embeds: GraphQLNullable<[EmbedInput]> {
    get { __data["embeds"] }
    set { __data["embeds"] = newValue }
  }

  public var associationId: Int {
    get { __data["associationId"] }
    set { __data["associationId"] = newValue }
  }

  public var pinned: GraphQLNullable<Bool> {
    get { __data["pinned"] }
    set { __data["pinned"] = newValue }
  }
}
