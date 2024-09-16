//
//  TPU_MacApp.swift
//  TPU Mac
//
//  Created by ElectricS01  on 6/10/2023.
//

import NukeUI
import PrivateUploaderAPI
import SwiftUI
import UserNotifications

@main
struct TPU_MacApp: App {
  @Environment(\.scenePhase) private var scenePhase

  var body: some Scene {
    WindowGroup {
      ContentView()
        .onAppear {
          UNUserNotificationCenter.current().setBadgeCount(0)
        }
#if os(macOS)
        .frame(minWidth: 500, maxWidth: .infinity, minHeight: 250, maxHeight: .infinity)
#endif
    }
  }
}

struct ProfilePicture: View {
  var avatar: String?
  var size: CGFloat = 32

  var body: some View {
    if let avatar = avatar, avatar.count < 21 {
      LazyImage(url: URL(string: "https://i.electrics01.com/i/" + avatar)) { state in
        if let image = state.image {
          image.resizable().aspectRatio(contentMode: .fill)
        } else if state.error != nil {
          Color.red
        } else {
          ProgressView()
        }
      }
      .frame(width: size, height: size)
      .cornerRadius(size / 2)
    } else {
      Image(systemName: "person.crop.circle").frame(width: size, height: size).font(.largeTitle)
    }
  }
}
