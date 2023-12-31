// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public typealias ID = String

public protocol SelectionSet: ApolloAPI.SelectionSet & ApolloAPI.RootSelectionSet
where Schema == PrivateUploaderAPI.SchemaMetadata {}

public protocol InlineFragment: ApolloAPI.SelectionSet & ApolloAPI.InlineFragment
where Schema == PrivateUploaderAPI.SchemaMetadata {}

public protocol MutableSelectionSet: ApolloAPI.MutableRootSelectionSet
where Schema == PrivateUploaderAPI.SchemaMetadata {}

public protocol MutableInlineFragment: ApolloAPI.MutableSelectionSet & ApolloAPI.InlineFragment
where Schema == PrivateUploaderAPI.SchemaMetadata {}

public enum SchemaMetadata: ApolloAPI.SchemaMetadata {
  public static let configuration: ApolloAPI.SchemaConfiguration.Type = SchemaConfiguration.self

  public static func objectType(forTypename typename: String) -> Object? {
    switch typename {
    case "Mutation": return PrivateUploaderAPI.Objects.Mutation
    case "LoginResponse": return PrivateUploaderAPI.Objects.LoginResponse
    case "LoginUser": return PrivateUploaderAPI.Objects.LoginUser
    case "Query": return PrivateUploaderAPI.Objects.Query
    case "PaginatedUploadResponse": return PrivateUploaderAPI.Objects.PaginatedUploadResponse
    case "Upload": return PrivateUploaderAPI.Objects.Upload
    case "Chat": return PrivateUploaderAPI.Objects.Chat
    case "ChatAssociation": return PrivateUploaderAPI.Objects.ChatAssociation
    case "PartialUserBase": return PrivateUploaderAPI.Objects.PartialUserBase
    case "Message": return PrivateUploaderAPI.Objects.Message
    case "ChatEmoji": return PrivateUploaderAPI.Objects.ChatEmoji
    case "EmbedDataV2": return PrivateUploaderAPI.Objects.EmbedDataV2
    case "EmbedMedia": return PrivateUploaderAPI.Objects.EmbedMedia
    case "EmbedText": return PrivateUploaderAPI.Objects.EmbedText
    case "EmbedMetadata": return PrivateUploaderAPI.Objects.EmbedMetadata
    case "ReadReceipt": return PrivateUploaderAPI.Objects.ReadReceipt
    case "PaginatedMessageResponse": return PrivateUploaderAPI.Objects.PaginatedMessageResponse
    case "Pager": return PrivateUploaderAPI.Objects.Pager
    default: return nil
    }
  }
}

public enum Objects {}
public enum Interfaces {}
public enum Unions {}
