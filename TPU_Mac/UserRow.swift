//
//  UserRow.swift
//  TPU Mac
//
//  Created by ElectricS01  on 25/2/2026.
//

import PrivateUploaderAPI
import SwiftUI

struct UserRow: View {
  let user: StateQuery.Data.TrackedUser
  var isOffline = false
  @EnvironmentObject var store: Store

  private var statusColor: Color {
    if isOffline { return .gray }
    switch user.status.value {
    case .online: return .green
    case .busy: return .red
    default: return .yellow
    }
  }

  var body: some View {
    Button {
      print(user.username)
    } label: {
      HStack {
        ProfilePicture(avatar: user.avatar)
          .overlay(alignment: .bottomTrailing) {
            Circle()
              .fill(statusColor)
              .frame(width: 10, height: 10)
              .overlay(
                Circle()
                  .stroke(.background, lineWidth: 2)
              )
          }

        Text(user.username)
          .foregroundStyle(isOffline ? .gray : .primary)

        Spacer()
      }
      .contentShape(Rectangle())
    }
    .buttonStyle(.plain)
    .contextMenu {
      Button {
        print(user.username)
      } label: {
        Label("Show Profile", systemImage: "person")
      }
      Divider()
      if user.friend == .none && user.id != store.coreUser?.id {
        Button {
          print("Action for context menu item 1")
        } label: {
          Label("Add friend", systemImage: "person.badge.plus")
        }
        Divider()
      }
      else if user.friend == .incoming {
        Button {
          print("Action for context menu item 2")
        } label: {
          Label("Accept friend", systemImage: "person.badge.plus")
        }
        Divider()
      }
      else if user.friend == .outgoing {
        Button {
          print("Action for context menu item 3")
        } label: {
          Label("Cancel friend", systemImage: "person.badge.minus")
        }
        Divider()
      }
      else if user.friend == .accepted {
        Button {
          print("Action for context menu item 4")
        } label: {
          Label("Remove friend", systemImage: "person.badge.minus")
        }
        Divider()
      }

      Button {
        copyToClipboard(String(user.id))
      } label: {
        Label("Copy User ID", systemImage: "person.text.rectangle")
      }
    }
  }
}
