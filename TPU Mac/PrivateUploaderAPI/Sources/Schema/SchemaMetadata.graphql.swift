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

  public static func objectType(forTypename typename: String) -> ApolloAPI.Object? {
    switch typename {
    case "Query": return PrivateUploaderAPI.Objects.Query
    case "CoreState": return PrivateUploaderAPI.Objects.CoreState
    case "Connection": return PrivateUploaderAPI.Objects.Connection
    case "Announcement": return PrivateUploaderAPI.Objects.Announcement
    case "PartialUserBase": return PrivateUploaderAPI.Objects.PartialUserBase
    case "CoreStats": return PrivateUploaderAPI.Objects.CoreStats
    case "Mutation": return PrivateUploaderAPI.Objects.Mutation
    case "LoginResponse": return PrivateUploaderAPI.Objects.LoginResponse
    case "LoginUser": return PrivateUploaderAPI.Objects.LoginUser
    case "PaginatedUploadResponse": return PrivateUploaderAPI.Objects.PaginatedUploadResponse
    case "Pager": return PrivateUploaderAPI.Objects.Pager
    case "Upload": return PrivateUploaderAPI.Objects.Upload
    case "Star": return PrivateUploaderAPI.Objects.Star
    case "GenericSuccessObject": return PrivateUploaderAPI.Objects.GenericSuccessObject
    case "Chat": return PrivateUploaderAPI.Objects.Chat
    case "ChatAssociation": return PrivateUploaderAPI.Objects.ChatAssociation
    case "Message": return PrivateUploaderAPI.Objects.Message
    case "Subscription": return PrivateUploaderAPI.Objects.Subscription
    case "MessageSubscription": return PrivateUploaderAPI.Objects.MessageSubscription
    case "ChatEmoji": return PrivateUploaderAPI.Objects.ChatEmoji
    case "EmbedDataV2": return PrivateUploaderAPI.Objects.EmbedDataV2
    case "EmbedMedia": return PrivateUploaderAPI.Objects.EmbedMedia
    case "EmbedText": return PrivateUploaderAPI.Objects.EmbedText
    case "EmbedMetadata": return PrivateUploaderAPI.Objects.EmbedMetadata
    case "ReadReceipt": return PrivateUploaderAPI.Objects.ReadReceipt
    case "PaginatedMessageResponse": return PrivateUploaderAPI.Objects.PaginatedMessageResponse
    default: return nil
    }
  }
}

public enum Objects {}
public enum Interfaces {}
public enum Unions {}
