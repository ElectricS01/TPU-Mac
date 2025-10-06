// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public struct UpdateUserInput: InputObject {
  public private(set) var __data: InputDict

  public init(_ data: InputDict) {
    __data = data
  }

  public init(
    username: GraphQLNullable<String> = nil,
    email: GraphQLNullable<String> = nil,
    discordPrecache: GraphQLNullable<Bool> = nil,
    darkTheme: GraphQLNullable<Bool> = nil,
    description: GraphQLNullable<String> = nil,
    itemsPerPage: GraphQLNullable<Int> = nil,
    storedStatus: GraphQLNullable<String> = nil,
    weatherUnit: GraphQLNullable<String> = nil,
    themeEngine: GraphQLNullable<JSON> = nil,
    insights: GraphQLNullable<String> = nil,
    profileLayout: GraphQLNullable<JSON> = nil,
    language: GraphQLNullable<String> = nil,
    excludedCollections: GraphQLNullable<[Int]> = nil,
    publicProfile: GraphQLNullable<Bool> = nil,
    privacyPolicyAccepted: GraphQLNullable<Bool> = nil,
    nameColor: GraphQLNullable<String> = nil,
    groupPrivacy: GraphQLNullable<GraphQLEnum<UserGroupPrivacy>> = nil,
    pulse: GraphQLNullable<Bool> = nil,
    friendRequests: GraphQLNullable<GraphQLEnum<UserFriendRequestPrivacy>> = nil
  ) {
    __data = InputDict([
      "username": username,
      "email": email,
      "discordPrecache": discordPrecache,
      "darkTheme": darkTheme,
      "description": description,
      "itemsPerPage": itemsPerPage,
      "storedStatus": storedStatus,
      "weatherUnit": weatherUnit,
      "themeEngine": themeEngine,
      "insights": insights,
      "profileLayout": profileLayout,
      "language": language,
      "excludedCollections": excludedCollections,
      "publicProfile": publicProfile,
      "privacyPolicyAccepted": privacyPolicyAccepted,
      "nameColor": nameColor,
      "groupPrivacy": groupPrivacy,
      "pulse": pulse,
      "friendRequests": friendRequests
    ])
  }

  public var username: GraphQLNullable<String> {
    get { __data["username"] }
    set { __data["username"] = newValue }
  }

  public var email: GraphQLNullable<String> {
    get { __data["email"] }
    set { __data["email"] = newValue }
  }

  public var discordPrecache: GraphQLNullable<Bool> {
    get { __data["discordPrecache"] }
    set { __data["discordPrecache"] = newValue }
  }

  public var darkTheme: GraphQLNullable<Bool> {
    get { __data["darkTheme"] }
    set { __data["darkTheme"] = newValue }
  }

  public var description: GraphQLNullable<String> {
    get { __data["description"] }
    set { __data["description"] = newValue }
  }

  public var itemsPerPage: GraphQLNullable<Int> {
    get { __data["itemsPerPage"] }
    set { __data["itemsPerPage"] = newValue }
  }

  public var storedStatus: GraphQLNullable<String> {
    get { __data["storedStatus"] }
    set { __data["storedStatus"] = newValue }
  }

  public var weatherUnit: GraphQLNullable<String> {
    get { __data["weatherUnit"] }
    set { __data["weatherUnit"] = newValue }
  }

  public var themeEngine: GraphQLNullable<JSON> {
    get { __data["themeEngine"] }
    set { __data["themeEngine"] = newValue }
  }

  public var insights: GraphQLNullable<String> {
    get { __data["insights"] }
    set { __data["insights"] = newValue }
  }

  public var profileLayout: GraphQLNullable<JSON> {
    get { __data["profileLayout"] }
    set { __data["profileLayout"] = newValue }
  }

  public var language: GraphQLNullable<String> {
    get { __data["language"] }
    set { __data["language"] = newValue }
  }

  public var excludedCollections: GraphQLNullable<[Int]> {
    get { __data["excludedCollections"] }
    set { __data["excludedCollections"] = newValue }
  }

  public var publicProfile: GraphQLNullable<Bool> {
    get { __data["publicProfile"] }
    set { __data["publicProfile"] = newValue }
  }

  public var privacyPolicyAccepted: GraphQLNullable<Bool> {
    get { __data["privacyPolicyAccepted"] }
    set { __data["privacyPolicyAccepted"] = newValue }
  }

  public var nameColor: GraphQLNullable<String> {
    get { __data["nameColor"] }
    set { __data["nameColor"] = newValue }
  }

  public var groupPrivacy: GraphQLNullable<GraphQLEnum<UserGroupPrivacy>> {
    get { __data["groupPrivacy"] }
    set { __data["groupPrivacy"] = newValue }
  }

  public var pulse: GraphQLNullable<Bool> {
    get { __data["pulse"] }
    set { __data["pulse"] = newValue }
  }

  public var friendRequests: GraphQLNullable<GraphQLEnum<UserFriendRequestPrivacy>> {
    get { __data["friendRequests"] }
    set { __data["friendRequests"] = newValue }
  }
}
