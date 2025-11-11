//
//  HomeView.swift
//  TPU Mac
//
//  Created by ElectricS01  on 26/2/2024.
//

import Apollo
import MarkdownUI
import PrivateUploaderAPI
import SwiftUI

struct HomeStat: View {
  @Binding var stat: String
  @Binding var type: String

  var body: some View {
    VStack {
      Text(stat).font(.system(size: 24, weight: .semibold))
      Text(type)
    }
    #if os(macOS)
    .frame(minWidth: 150, minHeight: 150)
    #else
    .frame(minWidth: 150, minHeight: 100)
    #endif
    .background(.ultraThinMaterial)
    .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
  }
}

struct NewsItem: View {
  @Binding var item: StateQuery.Data.CoreState.Announcement

  var body: some View {
    ProfilePicture(avatar: item.user?.avatar, size: 48)
    Text(item.user?.username ?? "Deleted User").font(.system(size: 16, weight: .semibold))
    Markdown(item.content)
      .markdownSoftBreakMode(.lineBreak)
      .textSelection(.enabled)
      .markdownBlockStyle(\.blockquote) { configuration in
        configuration.label
          .padding(EdgeInsets(top: 2, leading: 8, bottom: 2, trailing: 2))
          .overlay(alignment: .leading) {
            Rectangle().frame(width: 2)
          }
      }
      .multilineTextAlignment(.center)
    Text(DateUtils.dateFormat(item.createdAt))
  }
}

struct HomeView: View {
  @EnvironmentObject var store: Store

  var body: some View {
    HStack {
      VStack {
        VStack {
          Text("Welcome to").navigationTitle("Home")
          Text(Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ?? "").font(.system(size: 32, weight: .semibold))
        }.frame(maxHeight: .infinity)
        VStack {
          Text("Announcments").font(.system(size: 24, weight: .semibold))
          ScrollView {
            ForEach(store.coreState?.announcements ?? [], id: \.self) { item in
              NewsItem(item: .constant(item))
            }.padding()
          }
        }.frame(maxHeight: .infinity)
      }.frame(maxWidth: .infinity)
      LazyVGrid(columns: [GridItem(.adaptive(minimum: 160))], spacing: 20) {
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
