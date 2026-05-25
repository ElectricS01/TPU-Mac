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
  var isTyping = false

  private var statusColor: Color {
    switch status {
    case .offline: .gray
    case .online: .green
    case .busy: .red
    default: .yellow
    }
  }

  var body: some View {
    ZStack {
      ProfilePicture(avatar: avatar)
        .compositingGroup()
        .mask {
          ZStack {
            Circle()

            Capsule()
              .frame(width: isTyping ? 28 : 12, height: 12)
              .blendMode(.destinationOut)
              .offset(x: 10, y: 10)
              .animation(.spring(duration: 0.25), value: isTyping)
          }
        }

      TypingIndicatorView(status: statusColor, isTyping: isTyping)
        .frame(width: 12, height: 12)
        .offset(x: 10, y: 10)
    }
  }
}

struct TypingIndicatorView: View {
  var status: Color
  var isTyping: Bool

  var body: some View {
    HStack(spacing: isTyping ? 3 : 0) {
      if isTyping {
        TypingIndicatorDotView(delay: 0)
        TypingIndicatorDotView(delay: 0.15)
        TypingIndicatorDotView(delay: 0.3)
      }
    }
    .frame(width: isTyping ? 24 : 8, height: 8)
    .background(status)
    .clipShape(Capsule())
    .animation(.spring(duration: 0.25), value: isTyping)
  }
}

struct TypingIndicatorDotView: View {
  let delay: Double

  @State private var animate = false

  var body: some View {
    Circle()
      .fill(.white)
      .frame(width: 4, height: 4)
      .scaleEffect(animate ? 1 : 0.85)
      .opacity(animate ? 1.0 : 0.4)
      .animation(
        .easeInOut(duration: 1.0)
          .repeatForever(autoreverses: true)
          .delay(delay),
        value: animate
      )
      .onAppear {
        animate = true
      }
  }
}
