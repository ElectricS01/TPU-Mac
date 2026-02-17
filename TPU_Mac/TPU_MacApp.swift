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

enum Destination: Hashable {
  case home, settings, gallery, stars, collections, comms, about
}

@main
struct TPU_MacApp: App {
  #if os(macOS)
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
  #endif
  @Environment(\.scenePhase) private var scenePhase
  @State private var selection: Destination = .home

  var body: some Scene {
    WindowGroup {
      ContentView(selection: $selection)
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
    .commands {
      CommandGroup(after: .sidebar) {
        Button("Home") { selection = .home }.keyboardShortcut("1", modifiers: [.command])
        Button("Settings") { selection = .settings }.keyboardShortcut("2", modifiers: [.command])
        Button("Gallery") { selection = .gallery }.keyboardShortcut("3", modifiers: [.command])
        Button("Stars") { selection = .stars }.keyboardShortcut("4", modifiers: [.command])
        Button("Collections") { selection = .collections }.keyboardShortcut("5", modifiers: [.command])
        Button("Comms") { selection = .comms }.keyboardShortcut("6", modifiers: [.command])
        Button("About") { selection = .about }.keyboardShortcut("7", modifiers: [.command])
      }
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
      Image(systemName: "person.crop.circle").frame(width: size, height: size).font(.system(size: CGFloat(size)))
    }
  }
}

func copyToClipboard(_ string: String) {
  #if os(iOS)
    UIPasteboard.general.string = string
  #elseif os(macOS)
    NSPasteboard.general.clearContents()
    NSPasteboard.general.setString(string, forType: .string)
  #endif
}
