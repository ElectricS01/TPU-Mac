//
//  CollectionsView.swift
//  TPU Mac
//
//  Created by ElectricS01  on 11/5/2024.
//

import Apollo
import AVKit
import NukeUI
import PrivateUploaderAPI
import SwiftUI

struct CollectionsView: View {
  @Environment(\.openURL) var openURL
  @State private var collectionData: UserCollectionsQuery.Data.Collections?
  @State private var collectionItems: [UserCollectionsQuery.Data.Collections.Item] = []
  @State private var isPlaying: Int = -1
  @State private var currentPage: Int = 1
  @State private var inputSearch: String = ""
  @State private var showImages: Bool = true
  @State private var showVideos: Bool = true
  @State private var showOther: Bool = true
  @State private var showingSheet: Bool = false

  func getCollections() {
    var filters: [String] = []
    if showImages { filters.append("IMAGES") }
    if showVideos { filters.append("VIDEOS") }
    if showOther { filters.append("OTHER") }
    if filters.count == 3 { filters = [] }
    Network.shared.apollo.fetch(query: UserCollectionsQuery(input: UserCollectionsInput(InputDict([
      "search": inputSearch,
      "page": currentPage,
      "limit": 36,
      "filter": filters
    ]))), cachePolicy: .fetchIgnoringCacheData) { result in
      switch result {
      case .success(let graphQLResult):
        if let unwrapped = graphQLResult.data {
          collectionData = unwrapped.collections
          collectionItems = unwrapped.collections.items
        }
      case .failure(let error):
        print(error)
      }
    }
  }

  func formatFileSize(_ size: Double) -> String {
    let byteCountFormatter = ByteCountFormatter()
    byteCountFormatter.allowedUnits = [.useKB, .useMB, .useGB]
    byteCountFormatter.countStyle = .file
    return byteCountFormatter.string(fromByteCount: Int64(size))
  }

  var body: some View {
    VStack {
      HStack {
        TextField("Search your Collections", text: $inputSearch)
          .onSubmit {
            currentPage = 1
            getCollections()
          }.textFieldStyle(RoundedBorderTextFieldStyle())
        #if os(macOS)
        Toggle(isOn: $showImages) {
          Text("Images")
        }.onChange(of: showImages) {
          getCollections()
        }
        Toggle(isOn: $showVideos) {
          Text("Video")
        }.onChange(of: showVideos) {
          getCollections()
        }
        Toggle(isOn: $showOther) {
          Text("Other")
        }.onChange(of: showOther) {
          getCollections()
        }
        #else
        Button(action: { showingSheet.toggle() }) {
          Circle()
            .fill(showImages && showVideos && showOther ? .gray.opacity(0.15) : .blue)
            .frame(width: 30, height: 30)
            .overlay {
              Image(systemName: "line.3.horizontal.decrease")
                .font(.system(size: 13.0, weight: .semibold))
                .foregroundColor(showImages && showVideos && showOther ? .blue : .primary)
            }.sheet(isPresented: $showingSheet) {
              NavigationView {
                Form {
                  Button(action: {
                    showImages = true
                    showVideos = true
                    showOther = true
                    getCollections()
                  }) {
                    HStack {
                      Label {
                        Text("All Items").foregroundColor(.primary)
                      } icon: {
                        Image(systemName: "photo.on.rectangle")
                      }
                      if showImages && showVideos && showOther {
                        Spacer()
                        Image(systemName: "checkmark").foregroundColor(.blue)
                      }
                    }
                  }
                  Section(header: Text("Show")) {
                    Button(action: {
                      showImages.toggle()
                      getCollections()
                    }) {
                      HStack {
                        Label {
                          Text("Images").foregroundColor(.primary)
                        } icon: {
                          Image(systemName: "photo")
                        }
                        if showImages {
                          Spacer()
                          Image(systemName: "checkmark").foregroundColor(.blue)
                        }
                      }
                    }
                    Button(action: {
                      showVideos.toggle()
                      getCollections()
                    }) {
                      HStack {
                        Label {
                          Text("Videos").foregroundColor(.primary)
                        } icon: {
                          Image(systemName: "video")
                        }
                        if showVideos {
                          Spacer()
                          Image(systemName: "checkmark").foregroundColor(.blue)
                        }
                      }
                    }
                    Button(action: {
                      showOther.toggle()
                      getCollections()
                    }) {
                      HStack {
                        Label {
                          Text("Other").foregroundColor(.primary)
                        } icon: {
                          Image(systemName: "doc")
                        }
                        if showOther {
                          Spacer()
                          Image(systemName: "checkmark").foregroundColor(.blue)
                        }
                      }
                    }
                  }
                }
                .toolbar {
                  ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                      self.showingSheet = false
                    }) {
                      Text("Done").bold()
                    }
                  }
                }
                .navigationTitle("Filter")
                .navigationBarTitleDisplayMode(.inline)
              }
            }
        }
        #endif
      }.padding(EdgeInsets(top: 10, leading: 10, bottom: -8, trailing: 10))
      ScrollViewReader { _ in
        ScrollView {
          LazyVGrid(columns: [GridItem(.adaptive(minimum: 316))], spacing: 10) {
            ForEach($collectionItems, id: \.self) { collectionItem in
              HStack(alignment: .center) {
                LazyImage(url: URL(string: "https://i.electrics01.com/i/" + (collectionItem.wrappedValue.banner ?? "a050d6f271c3.png"))) { state in
                  if let image = state.image {
                    image.resizable().aspectRatio(contentMode: .fill)
                  } else if state.error != nil {
                    Color.red
                  } else {
                    ProgressView()
                  }
                }.frame(minWidth: 300, maxWidth: .infinity, minHeight: 200, maxHeight: 200).overlay(alignment: .bottom) {
                  VStack(alignment: .leading) {
                    Text(collectionItem.wrappedValue.name).font(.title2).lineLimit(1)
                    Text("Upload count: " + String(collectionItem.wrappedValue.itemCount ?? 0))
                    Text("Link: " + (collectionItem.wrappedValue.shareLink ?? "none"))
                    Text("Created at: " + DateUtils.dateFormat(collectionItem.wrappedValue.createdAt))
                    Text("Owner: " + (collectionItem.wrappedValue.user?.username ?? "none"))
                  }
                }
              }
              .padding()
              .frame(minWidth: 300, minHeight: 200)
              .background()
              .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
            }
          }
          .id(0)
          .padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10))
          HStack {
            Text("Pages: " + String(collectionData?.pager.totalPages ?? 0))
            Button("Last Page") {
              currentPage -= 1
              getCollections()
            }
            .disabled(currentPage < 2)
            Button("Next Page") {
              currentPage += 1
              getCollections()
            }
            .disabled(currentPage >= collectionData?.pager.totalPages ?? 0)
            Text("Page: " + String(currentPage))
          }
          .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
        }
        .navigationTitle("Collections")
        .onAppear {
          getCollections()
        }
      }
    }
  }
}
