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

  private static let objectTypeMap: [String: ApolloAPI.Object] = [
    "Announcement": PrivateUploaderAPI.Objects.Announcement,
    "Badge": PrivateUploaderAPI.Objects.Badge,
    "Chat": PrivateUploaderAPI.Objects.Chat,
    "ChatAssociation": PrivateUploaderAPI.Objects.ChatAssociation,
    "ChatEmoji": PrivateUploaderAPI.Objects.ChatEmoji,
    "Collection": PrivateUploaderAPI.Objects.Collection,
    "CollectionItem": PrivateUploaderAPI.Objects.CollectionItem,
    "CoreState": PrivateUploaderAPI.Objects.CoreState,
    "CoreStats": PrivateUploaderAPI.Objects.CoreStats,
    "DeleteMessage": PrivateUploaderAPI.Objects.DeleteMessage,
    "Domain": PrivateUploaderAPI.Objects.Domain,
    "EditMessageEvent": PrivateUploaderAPI.Objects.EditMessageEvent,
    "EmbedDataV2": PrivateUploaderAPI.Objects.EmbedDataV2,
    "EmbedMedia": PrivateUploaderAPI.Objects.EmbedMedia,
    "EmbedText": PrivateUploaderAPI.Objects.EmbedText,
    "FriendNickname": PrivateUploaderAPI.Objects.FriendNickname,
    "GenericSuccessObject": PrivateUploaderAPI.Objects.GenericSuccessObject,
    "LoginResponse": PrivateUploaderAPI.Objects.LoginResponse,
    "Message": PrivateUploaderAPI.Objects.Message,
    "MessageSubscription": PrivateUploaderAPI.Objects.MessageSubscription,
    "Mutation": PrivateUploaderAPI.Objects.Mutation,
    "Notification": PrivateUploaderAPI.Objects.Notification,
    "Pager": PrivateUploaderAPI.Objects.Pager,
    "PaginatedCollectionResponse": PrivateUploaderAPI.Objects.PaginatedCollectionResponse,
    "PaginatedMessageResponse": PrivateUploaderAPI.Objects.PaginatedMessageResponse,
    "PaginatedUploadResponse": PrivateUploaderAPI.Objects.PaginatedUploadResponse,
    "PartialUserBase": PrivateUploaderAPI.Objects.PartialUserBase,
    "PartialUserFriend": PrivateUploaderAPI.Objects.PartialUserFriend,
    "PartialUserPublic": PrivateUploaderAPI.Objects.PartialUserPublic,
    "PermissionsMetadata": PrivateUploaderAPI.Objects.PermissionsMetadata,
    "Query": PrivateUploaderAPI.Objects.Query,
    "ReadReceipt": PrivateUploaderAPI.Objects.ReadReceipt,
    "Star": PrivateUploaderAPI.Objects.Star,
    "StarUploadResponse": PrivateUploaderAPI.Objects.StarUploadResponse,
    "StatusEvent": PrivateUploaderAPI.Objects.StatusEvent,
    "Subscription": PrivateUploaderAPI.Objects.Subscription,
    "Upload": PrivateUploaderAPI.Objects.Upload,
    "User": PrivateUploaderAPI.Objects.User
  ]

  @_spi(Execution) public static func objectType(forTypename typename: String) -> ApolloAPI.Object? {
    objectTypeMap[typename]
  }
}

public enum Objects {}
public enum Interfaces {}
public enum Unions {}
