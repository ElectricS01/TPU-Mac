//
//  HomeView.swift
//  TPU Mac
//
//  Created by ElectricS01  on 26/2/2024.
//

import Apollo
import PrivateUploaderAPI
import SwiftUI

struct HomeStat: View {
  @Binding var stat: String
  @Binding var type: String

  var body: some View {
    VStack {
      Text(stat).font(.system(size: 24, weight: .semibold))
      Text(type)
    }.frame(minWidth: 150, minHeight: 150)
      .background()
      .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
  }
}

struct HomeView: View {
  @Binding var showingLogin: Bool
  @Binding var coreState: StateQuery.Data.CoreState?

  var body: some View {
    HStack {
      VStack {
        Text("Welcome to")
        #if os(macOS)
          Text("TPU Mac").font(.system(size: 32, weight: .semibold))
        #else
          Text("TPU iOS").font(.system(size: 32, weight: .semibold))
        #endif
        Button("Backup Login") {
          showingLogin = true
        }
        .navigationTitle("Home")
      }
      .frame(maxWidth: .infinity)
      LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 10) {
        HomeStat(stat: .constant(String(coreState?.stats.collections ?? 0)), type: .constant("Collections"))
        HomeStat(stat: .constant(String(coreState?.stats.collectionItems ?? 0)), type: .constant("Collection Items"))
        HomeStat(stat: .constant(String(coreState?.stats.users ?? 0)), type: .constant("Users"))
        HomeStat(stat: .constant(String(coreState?.stats.uploads ?? 0)), type: .constant("Uploads"))
        HomeStat(stat: .constant(String(coreState?.stats.chats ?? 0)), type: .constant("Chats"))
        HomeStat(stat: .constant(String(coreState?.stats.messages ?? 0)), type: .constant("Chats"))
      }
      .padding(20)
      .frame(maxWidth: .infinity)
    }
  }
}
