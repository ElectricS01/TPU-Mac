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
  @State private var showOwned: Bool = true
  @State private var showShared: Bool = true
  @State private var showingSheet: Bool = false

  func getCollections() {
    var filters: [String] = []
    if showOwned { filters.append("OWNED") }
    if showShared { filters.append("SHARED") }
    if filters.count == 2 { filters = [] }
    Network.shared.apollo.fetch(query: UserCollectionsQuery(input: UserCollectionsInput(InputDict([
      "search": inputSearch,
      "page": currentPage,
      "limit": 36,
      "filter": filters
    ]))), cachePolicy: .returnCacheDataAndFetch) { result in
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
        Toggle(isOn: $showOwned) {
          Text("Owned")
        }.onChange(of: showOwned) {
          getCollections()
        }
        Toggle(isOn: $showShared) {
          Text("Shared")
        }.onChange(of: showShared) {
          getCollections()
        }
        #else
        Button(action: { showingSheet.toggle() }) {
          Circle()
            .fill(showOwned && showShared ? .gray.opacity(0.15) : .blue)
            .frame(width: 30, height: 30)
            .overlay {
              Image(systemName: "line.3.horizontal.decrease")
                .font(.system(size: 13.0, weight: .semibold))
                .foregroundColor(showOwned && showShared ? .blue : .primary)
            }.sheet(isPresented: $showingSheet) {
              NavigationView {
                Form {
                  Button(action: {
                    showOwned = true
                    showShared = true
                    getCollections()
                  }) {
                    HStack {
                      Label {
                        Text("All Items").foregroundColor(.primary)
                      } icon: {
                        Image(systemName: "photo.on.rectangle")
                      }
                      if showOwned && showShared {
                        Spacer()
                        Image(systemName: "checkmark").foregroundColor(.blue)
                      }
                    }
                  }
                  Section(header: Text("Show")) {
                    Button(action: {
                      showOwned.toggle()
                      getCollections()
                    }) {
                      HStack {
                        Label {
                          Text("Owned").foregroundColor(.primary)
                        } icon: {
                          Image(systemName: "person")
                        }
                        if showOwned {
                          Spacer()
                          Image(systemName: "checkmark").foregroundColor(.blue)
                        }
                      }
                    }
                    Button(action: {
                      showShared.toggle()
                      getCollections()
                    }) {
                      HStack {
                        Label {
                          Text("Shared").foregroundColor(.primary)
                        } icon: {
                          Image(systemName: "shared.with.you")
                        }
                        if showShared {
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
                  VStack(alignment: .leading, spacing: 4) {
                    Text(collectionItem.wrappedValue.name).font(.title2).lineLimit(1)
                    Text("Upload count: " + String(collectionItem.wrappedValue.itemCount ?? 0))
                    Text("Created at: " + DateUtils.dateFormat(collectionItem.wrappedValue.createdAt))
                    Text("Owner: " + (collectionItem.wrappedValue.user?.username ?? "none"))
                  }
                  .padding()
                  .frame(maxWidth: .infinity, alignment: .leading)
                  .background(Color.black.opacity(0.7)) // Dark background with opacity
                }
              }
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
