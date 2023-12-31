// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public struct SendMessageInput: InputObject {
  public private(set) var __data: InputDict

  public init(_ data: InputDict) {
    __data = data
  }

  public init(
    content: String,
    associationId: Double,
    attachments: [String]?,
    replyId: GraphQLNullable<Double> = nil,
    embeds: GraphQLNullable<[EmbedInput]> = nil
  ) {
    __data = InputDict([
      "content": content,
      "associationId": associationId,
      "attachments": attachments,
      "replyId": replyId,
      "embeds": embeds
    ])
  }

  public var content: String {
    get { __data["content"] }
    set { __data["content"] = newValue }
  }

  public var associationId: Double {
    get { __data["associationId"] }
    set { __data["associationId"] = newValue }
  }

  public var attachments: [String]? {
    get { __data["attachments"] }
    set { __data["attachments"] = newValue }
  }

  public var replyId: GraphQLNullable<Double> {
    get { __data["replyId"] }
    set { __data["replyId"] = newValue }
  }

  public var embeds: GraphQLNullable<[EmbedInput]> {
    get { __data["embeds"] }
    set { __data["embeds"] = newValue }
  }
}
