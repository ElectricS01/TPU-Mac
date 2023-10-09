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
    case "Pager": return PrivateUploaderAPI.Objects.Pager
    case "Upload": return PrivateUploaderAPI.Objects.Upload
    case "AutoCollectApproval": return PrivateUploaderAPI.Objects.AutoCollectApproval
    case "PartialUserBase": return PrivateUploaderAPI.Objects.PartialUserBase
    case "Collection": return PrivateUploaderAPI.Objects.Collection
    case "CollectionItem": return PrivateUploaderAPI.Objects.CollectionItem
    case "Star": return PrivateUploaderAPI.Objects.Star
    default: return nil
    }
  }
}

public enum Objects {}
public enum Interfaces {}
public enum Unions {}
