//
//  CollectionView.swift
//  TPU Mac
//
//  Created by ElectricS01  on 21/9/2024.
//

import Apollo
import AVKit
import NukeUI
import PrivateUploaderAPI
import SwiftUI

struct CollectionView: View {
  @Binding var collection: UserCollectionsQuery.Data.Collections.Item

  var body: some View {
    NavigationStack {
      HStack(alignment: .center) {
        LazyImage(url: URL(string: "https://i.electrics01.com/i/" + (collection.banner ?? "a050d6f271c3.png"))) { state in
          if let image = state.image {
            image.resizable().aspectRatio(contentMode: .fill)
          } else if state.error != nil {
            Color.red
          } else {
            ProgressView()
          }
        }.frame(minWidth: 300, maxWidth: .infinity, minHeight: 200, maxHeight: 200).overlay(alignment: .bottom) {
          VStack(alignment: .leading, spacing: 4) {
            Text(collection.name).font(.title2).lineLimit(1)
            Text("Upload count: " + String(collection.itemCount ?? 0))
            Text("Created at: " + DateUtils.dateFormat(collection.createdAt))
            Text("Owner: " + (collection.user?.username ?? "none"))
          }
          .padding()
          .frame(maxWidth: .infinity, alignment: .leading)
          .background(Color.black.opacity(0.7))
        }
      }
      GalleryView(stars: .constant(false), collectionId: .constant(collection.id), collectionName: .constant(collection.name))
        .navigationTitle("Collections")
    }
  }
}
