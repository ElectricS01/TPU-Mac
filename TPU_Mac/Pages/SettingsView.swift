//
//  SettingsView.swift
//  TPU Mac
//
//  Created by ElectricS01  on 6/10/2025.
//

import SwiftUI

struct SettingsView: View {
  @Binding var showingLogin: Bool
  @EnvironmentObject var store: Store

  var body: some View {
    VStack {
      Text("Settings")
#if os(macOS)
      Text("Coming soon")
#else
      Text("TPU iOS").font(.system(size: 32, weight: .semibold))
      Text("Version " + (Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "") + " (01/03/2026)")
      Text("Made by ElectricS01")
      Text("[Give it a Star on GitHub](https://github.com/ElectricS01/TPU-Mac)")
#endif
      Text("Logged in as " + (store.coreUser?.username ?? "Unknown"))
      Button("Log out") {
        keychain.delete("token")
        showingLogin = true
      }
      .navigationTitle("Settings")
    }
  }
}
