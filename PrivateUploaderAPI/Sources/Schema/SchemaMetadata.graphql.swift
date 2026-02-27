// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public protocol SelectionSet: ApolloAPI.SelectionSet & ApolloAPI.RootSelectionSet
where Schema == PrivateUploaderAPI.SchemaMetadata {}

public protocol InlineFragment: ApolloAPI.SelectionSet & ApolloAPI.InlineFragment
where Schema == PrivateUploaderAPI.SchemaMetadata {}

public protocol MutableSelectionSet: ApolloAPI.MutableRootSelectionSet
where Schema == PrivateUploaderAPI.SchemaMetadata {}

public protocol MutableInlineFragment: ApolloAPI.MutableSelectionSet & ApolloAPI.InlineFragment
where Schema == PrivateUploaderAPI.SchemaMetadata {}

public enum SchemaMetadata: ApolloAPI.SchemaMetadata {
  public static let configuration: any ApolloAPI.SchemaConfiguration.Type = SchemaConfiguration.self

  public static func objectType(forTypename typename: String) -> ApolloAPI.Object? {
    switch typename {
    case "Announcement": return PrivateUploaderAPI.Objects.Announcement
    case "Badge": return PrivateUploaderAPI.Objects.Badge
    case "Chat": return PrivateUploaderAPI.Objects.Chat
    case "ChatAssociation": return PrivateUploaderAPI.Objects.ChatAssociation
    case "ChatEmoji": return PrivateUploaderAPI.Objects.ChatEmoji
    case "Collection": return PrivateUploaderAPI.Objects.Collection
    case "CollectionItem": return PrivateUploaderAPI.Objects.CollectionItem
    case "CoreState": return PrivateUploaderAPI.Objects.CoreState
    case "CoreStats": return PrivateUploaderAPI.Objects.CoreStats
    case "DeleteMessage": return PrivateUploaderAPI.Objects.DeleteMessage
    case "Domain": return PrivateUploaderAPI.Objects.Domain
    case "EditMessageEvent": return PrivateUploaderAPI.Objects.EditMessageEvent
    case "EmbedDataV2": return PrivateUploaderAPI.Objects.EmbedDataV2
    case "EmbedMedia": return PrivateUploaderAPI.Objects.EmbedMedia
    case "EmbedText": return PrivateUploaderAPI.Objects.EmbedText
    case "FriendNickname": return PrivateUploaderAPI.Objects.FriendNickname
    case "GenericSuccessObject": return PrivateUploaderAPI.Objects.GenericSuccessObject
    case "LoginResponse": return PrivateUploaderAPI.Objects.LoginResponse
    case "Message": return PrivateUploaderAPI.Objects.Message
    case "MessageSubscription": return PrivateUploaderAPI.Objects.MessageSubscription
    case "Mutation": return PrivateUploaderAPI.Objects.Mutation
    case "Notification": return PrivateUploaderAPI.Objects.Notification
    case "Pager": return PrivateUploaderAPI.Objects.Pager
    case "PaginatedCollectionResponse": return PrivateUploaderAPI.Objects.PaginatedCollectionResponse
    case "PaginatedMessageResponse": return PrivateUploaderAPI.Objects.PaginatedMessageResponse
    case "PaginatedUploadResponse": return PrivateUploaderAPI.Objects.PaginatedUploadResponse
    case "PartialUserBase": return PrivateUploaderAPI.Objects.PartialUserBase
    case "PartialUserFriend": return PrivateUploaderAPI.Objects.PartialUserFriend
    case "PermissionsMetadata": return PrivateUploaderAPI.Objects.PermissionsMetadata
    case "Query": return PrivateUploaderAPI.Objects.Query
    case "ReadReceipt": return PrivateUploaderAPI.Objects.ReadReceipt
    case "Star": return PrivateUploaderAPI.Objects.Star
    case "StarUploadResponse": return PrivateUploaderAPI.Objects.StarUploadResponse
    case "Subscription": return PrivateUploaderAPI.Objects.Subscription
    case "Upload": return PrivateUploaderAPI.Objects.Upload
    case "User": return PrivateUploaderAPI.Objects.User
    default: return nil
    }
  }
}

public enum Objects {}
public enum Interfaces {}
public enum Unions {}
