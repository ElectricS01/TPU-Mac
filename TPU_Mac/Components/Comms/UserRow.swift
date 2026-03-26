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
  @EnvironmentObject var showingUserStore: ShowingUserStore

  var body: some View {
    Button {
      showingUserStore.shownUser = user
      showingUserStore.isShowingUser = true
    } label: {
      HStack {
        ProfileStatus(avatar: user.avatar, status: user.status.value ?? .offline)

        Text(user.username)
          .foregroundStyle(isOffline ? .gray : .primary)

        Spacer()
      }
      .contentShape(Rectangle())
    }
    .buttonStyle(.plain)
    .listRowSeparator(.hidden)
    .contextMenu {
      Button {
        showingUserStore.shownUser = user
        showingUserStore.isShowingUser = true
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
