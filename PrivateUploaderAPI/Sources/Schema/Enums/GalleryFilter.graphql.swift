// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

/// The filter to apply to the gallery request
public enum GalleryFilter: String, EnumType {
  case all = "ALL"
  case owned = "OWNED"
  case shared = "SHARED"
  case noCollection = "NO_COLLECTION"
  case images = "IMAGES"
  case videos = "VIDEOS"
  case gifs = "GIFS"
  case audio = "AUDIO"
  case text = "TEXT"
  case other = "OTHER"
  case paste = "PASTE"
  case includeMetadata = "INCLUDE_METADATA"
  case includeUndeletable = "INCLUDE_UNDELETABLE"
  case onlyUndeletable = "ONLY_UNDELETABLE"
}
