// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class OnTypingSubscription: GraphQLSubscription {
  public static let operationName: String = "OnTyping"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"subscription OnTyping { onTyping { __typename chatId expires user { __typename username } } }"#
    ))

  public init() {}

  public struct Data: PrivateUploaderAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { PrivateUploaderAPI.Objects.Subscription }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("onTyping", OnTyping.self),
    ] }
    public static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
      OnTypingSubscription.Data.self
    ] }

    public var onTyping: OnTyping { __data["onTyping"] }

    /// OnTyping
    ///
    /// Parent Type: `ChatTypingEvent`
    public struct OnTyping: PrivateUploaderAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: any ApolloAPI.ParentType { PrivateUploaderAPI.Objects.ChatTypingEvent }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("chatId", Int.self),
        .field("expires", Double?.self),
        .field("user", User.self),
      ] }
      public static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
        OnTypingSubscription.Data.OnTyping.self
      ] }

      public var chatId: Int { __data["chatId"] }
      public var expires: Double? { __data["expires"] }
      public var user: User { __data["user"] }

      /// OnTyping.User
      ///
      /// Parent Type: `PartialUserFriend`
      public struct User: PrivateUploaderAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: any ApolloAPI.ParentType { PrivateUploaderAPI.Objects.PartialUserFriend }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("username", String.self),
        ] }
        public static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
          OnTypingSubscription.Data.OnTyping.User.self
        ] }

        public var username: String { __data["username"] }
      }
    }
  }
}
