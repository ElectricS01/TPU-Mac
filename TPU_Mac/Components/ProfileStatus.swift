//
//  ProfileStatus.swift
//  TPU Mac
//
//  Created by ElectricS01  on 26/3/2026.
//

import NukeUI
import PrivateUploaderAPI
import SwiftUI

struct ProfileStatus: View {
  var avatar: String?
  var status: PrivateUploaderAPI.UserStatus

  private var statusColor: Color {
    switch status {
    case .offline: .gray.opacity(1)
    case .online: .green.opacity(1)
    case .busy: .red.opacity(1)
    default: .yellow.opacity(1)
    }
  }

  var body: some View {
    ProfilePicture(avatar: avatar)
      .overlay(alignment: .bottomTrailing) {
        Circle()
          .fill(statusColor)
          .frame(width: 10, height: 10)
          .overlay {
            Circle()
              .stroke(Color(NSColor.windowBackgroundColor), lineWidth: 2)
          }
      }
  }
}
