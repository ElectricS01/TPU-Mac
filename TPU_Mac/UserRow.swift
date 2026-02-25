//
//  UserRow.swift
//  TPU_Mac
//
//  Created by ElectricS01  on 25/2/2026.
//

import SwiftUI
import PrivateUploaderAPI

struct UserRow: View {
  let user: StateQuery.Data.TrackedUser
  var isOffline = false

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
        Circle()
          .fill(statusColor)
          .frame(width: 6, height: 6)

        ProfilePicture(avatar: user.avatar)

        Text(user.username)
          .foregroundStyle(isOffline ? .gray : .primary)

        Spacer()
      }
      .contentShape(Rectangle())
    }
    .buttonStyle(.plain)
    .contextMenu {
      if user.status.rawValue == "NONE" {
        Button {
          print("Action for context menu item 1")
        } label: {
          Label("Add friend", systemImage: "person.badge.plus")
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
