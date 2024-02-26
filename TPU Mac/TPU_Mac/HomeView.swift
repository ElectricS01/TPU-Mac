//
//  HomeView.swift
//  TPU Mac
//
//  Created by ElectricS01  on 26/2/2024.
//

import Apollo
import PrivateUploaderAPI
import SwiftUI

struct HomeView: View {
  @Binding var showingLogin: Bool
  @Binding var coreState: StateQuery.Data.CoreState?

  var body: some View {
    Text("Welcome to")
    #if os(macOS)
      Text("TPU Mac").font(.system(size: 24, weight: .semibold))
    #else
      Text("TPU iOS").font(.system(size: 24, weight: .semibold))
    #endif
    Button("Backup Login") {
      showingLogin = true
    }
    .navigationTitle("Home")
  }
}
