// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

/// The type of message. Can be null for legacy (Colubrina) messages where `MESSAGE` should be inferred.
public enum MessageType: String, EnumType {
  case message = "MESSAGE"
  case leave = "LEAVE"
  case join = "JOIN"
  case pin = "PIN"
  case administrator = "ADMINISTRATOR"
  case rename = "RENAME"
  case system = "SYSTEM"
}
