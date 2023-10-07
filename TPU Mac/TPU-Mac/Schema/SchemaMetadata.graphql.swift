// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

protocol TPU-Mac_SelectionSet: ApolloAPI.SelectionSet & ApolloAPI.RootSelectionSet
where Schema == TPU-Mac.SchemaMetadata {}

protocol TPU-Mac_InlineFragment: ApolloAPI.SelectionSet & ApolloAPI.InlineFragment
where Schema == TPU-Mac.SchemaMetadata {}

protocol TPU-Mac_MutableSelectionSet: ApolloAPI.MutableRootSelectionSet
where Schema == TPU-Mac.SchemaMetadata {}

protocol TPU-Mac_MutableInlineFragment: ApolloAPI.MutableSelectionSet & ApolloAPI.InlineFragment
where Schema == TPU-Mac.SchemaMetadata {}

extension TPU-Mac {
  typealias ID = String

  typealias SelectionSet = TPU-Mac_SelectionSet

  typealias InlineFragment = TPU-Mac_InlineFragment

  typealias MutableSelectionSet = TPU-Mac_MutableSelectionSet

  typealias MutableInlineFragment = TPU-Mac_MutableInlineFragment

  enum SchemaMetadata: ApolloAPI.SchemaMetadata {
    static let configuration: ApolloAPI.SchemaConfiguration.Type = SchemaConfiguration.self

    static func objectType(forTypename typename: String) -> Object? {
      switch typename {
      case "Mutation": return TPU-Mac.Objects.Mutation
      case "LoginResponse": return TPU-Mac.Objects.LoginResponse
      case "LoginUser": return TPU-Mac.Objects.LoginUser
      default: return nil
      }
    }
  }

  enum Objects {}
  enum Interfaces {}
  enum Unions {}

}