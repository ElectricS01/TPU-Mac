// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public struct PagerFragment: PrivateUploaderAPI.SelectionSet, Fragment {
  public static var fragmentDefinition: StaticString {
    #"fragment PagerFragment on Pager { __typename totalItems currentPage pageSize totalPages startPage endPage startIndex endIndex pages }"#
  }

  public let __data: DataDict
  public init(_dataDict: DataDict) { __data = _dataDict }

  public static var __parentType: ApolloAPI.ParentType { PrivateUploaderAPI.Objects.Pager }
  public static var __selections: [ApolloAPI.Selection] { [
    .field("__typename", String.self),
    .field("totalItems", Int.self),
    .field("currentPage", Int.self),
    .field("pageSize", Int.self),
    .field("totalPages", Int.self),
    .field("startPage", Int.self),
    .field("endPage", Int.self),
    .field("startIndex", Int.self),
    .field("endIndex", Int.self),
    .field("pages", [Int].self),
  ] }

  public var totalItems: Int { __data["totalItems"] }
  public var currentPage: Int { __data["currentPage"] }
  public var pageSize: Int { __data["pageSize"] }
  public var totalPages: Int { __data["totalPages"] }
  public var startPage: Int { __data["startPage"] }
  public var endPage: Int { __data["endPage"] }
  public var startIndex: Int { __data["startIndex"] }
  public var endIndex: Int { __data["endIndex"] }
  public var pages: [Int] { __data["pages"] }
}
