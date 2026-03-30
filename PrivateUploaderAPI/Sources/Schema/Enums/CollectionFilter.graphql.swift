// @generated
// This file was automatically generated and should not be edited.

@_spi(Internal) import ApolloAPI

/// The type of collection
public enum CollectionFilter: String, EnumType {
  case all = "ALL"
  case write = "WRITE"
  case read = "READ"
  case configure = "CONFIGURE"
  case shared = "SHARED"
  case owned = "OWNED"
}
