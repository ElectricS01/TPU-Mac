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
  @EnvironmentObject var store: Store

  var body: some View {
    HStack {
      VStack {
        VStack {
          Text("Welcome to").navigationTitle("Home")
          Text(Bundle.main.infoDictionary?[kCFBundleNameKey as String] as? String ?? "").font(.system(size: 32, weight: .semibold))
        }.frame(maxHeight: .infinity)
        VStack {
          Text("Announcments").font(.system(size: 24, weight: .semibold))
          ScrollView {
            ForEach(store.coreState?.announcements ?? [], id: \.self) { item in
              ProfilePicture(avatar: item.user?.avatar, size: 48)
              Text(item.user?.username ?? "Deleted User").font(.system(size: 16, weight: .semibold))
              Text(item.content).multilineTextAlignment(.center)
              Text(DateUtils.dateFormat(item.createdAt))
            }.padding()
          }
        }.frame(maxHeight: .infinity)
      }.frame(maxWidth: .infinity)
      LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 10) {
        HomeStat(stat: .constant(String(store.coreState?.stats.collections ?? 0)), type: .constant("Collections"))
        HomeStat(stat: .constant(String(store.coreState?.stats.collectionItems ?? 0)), type: .constant("Collection Items"))
        HomeStat(stat: .constant(String(store.coreState?.stats.users ?? 0)), type: .constant("Users"))
        HomeStat(stat: .constant(String(store.coreState?.stats.uploads ?? 0)), type: .constant("Uploads"))
        HomeStat(stat: .constant(String(store.coreState?.stats.chats ?? 0)), type: .constant("Chats"))
        HomeStat(stat: .constant(String(store.coreState?.stats.messages ?? 0)), type: .constant("Chat Messages"))
      }
      .padding(20)
      .frame(maxWidth: .infinity)
    }
  }
}
