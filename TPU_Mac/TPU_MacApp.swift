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
  #if os(macOS)
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
  #endif
  @Environment(\.scenePhase) private var scenePhase

  var body: some Scene {
    WindowGroup {
      ContentView()
        .onAppear {
          UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { _, error in
            if let error = error {
              print("Error requesting notifications permission: \(error)")
            }
          }
          #if os(macOS)
            UNUserNotificationCenter.current().delegate = appDelegate
          #endif
          UNUserNotificationCenter.current().setBadgeCount(0)
        }
      #if os(macOS)
        .frame(minWidth: 500, maxWidth: .infinity, minHeight: 250, maxHeight: .infinity)
      #endif
    }
  }
}

#if os(macOS)
  class AppDelegate: NSObject, NSApplicationDelegate, UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
      let userInfo = response.notification.request.content.userInfo

      if let pageID = userInfo["to"] as? Int {
        NotificationCenter.default.post(name: NSNotification.Name("NavigateToPage"), object: nil, userInfo: ["to": pageID])
      }

      completionHandler()
    }
  }
#endif

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
