//
//  GalleryView.swift
//  TPU Mac
//
//  Created by ElectricS01  on 30/1/2024.
//

import Apollo
import AVKit
import PrivateUploaderAPI
import SwiftUI

struct GalleryView: View {
  @Environment(\.openURL) var openURL
  @State private var galleryData: GalleryItemsQuery.Data.Gallery?
  @State private var galleryItems: [GalleryItemsQuery.Data.Gallery.Item] = []
  @State private var isPlaying: Int = -1
  @State private var currentPage: Int = 1
  @State private var inputSearch: String = ""
  @State private var showImages: Bool = true
  @State private var showVideos: Bool = true
  @State private var showOther: Bool = true

  func getGallery() {
    var filters: [String] = []
    if showImages { filters.append("IMAGES") }
    if showVideos { filters.append("VIDEOS") }
    if showOther { filters.append("OTHER") }
    if filters.count == 3 { filters = [] }
    Network.shared.apollo.fetch(query: GalleryItemsQuery(input: GalleryInput(InputDict([
      "search": inputSearch,
      "page": currentPage,
      "limit": 36,
      "filters": filters
    ]))), cachePolicy: .fetchIgnoringCacheData) { result in
      switch result {
      case .success(let graphQLResult):
        if let unwrapped = graphQLResult.data {
          galleryData = unwrapped.gallery
          galleryItems = unwrapped.gallery.items
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
    HStack {
      TextField("Search the Gallery", text: $inputSearch)
        .onSubmit {
          currentPage = 1
          getGallery()
        }.textFieldStyle(RoundedBorderTextFieldStyle())
      Toggle(isOn: $showImages) {
        Text("Images")
      }
      .onChange(of: showImages) {
        getGallery()
      }
      Toggle(isOn: $showVideos) {
        Text("Video")
      }
      .onChange(of: showVideos) {
        getGallery()
      }
      Toggle(isOn: $showOther) {
        Text("Other")
      }
      .onChange(of: showOther) {
        getGallery()
      }
    }.padding(EdgeInsets(top: 10, leading: 10, bottom: -8, trailing: 10))
    ScrollView {
      LazyVGrid(columns: [GridItem(.adaptive(minimum: 316))], spacing: 10) {
        ForEach(galleryItems, id: \.self) { galleryItem in
          VStack(alignment: .leading) {
            HStack {
              Text(galleryItem.name ?? "Unknown").font(.title2).lineLimit(1)
              Spacer()
              Image(systemName: galleryItem.starred == nil ? "star" : "star.fill")
                .resizable()
                .frame(width: 16, height: 16)
                .foregroundColor(.white)
            }
            HStack(alignment: .center) {
              if galleryItem.type == "image" {
                CacheAsyncImage(
                  url: URL(string: "https://i.electrics01.com/i/" + galleryItem.attachment)
                ) { image in
                  image.resizable()
                    .aspectRatio(contentMode: .fit)
                } placeholder: {
                  ProgressView()
                }
                .frame(minWidth: 268, maxWidth: .infinity, minHeight: 160, maxHeight: 160)
              } else if galleryItem.type == "video" {
                if isPlaying != galleryItem.id {
                  Button(action: {
                    isPlaying = galleryItem.id
                  }) {
                    Image(systemName: "play.circle.fill")
                      .resizable()
                      .frame(width: 160, height: 160)
                      .foregroundColor(.white)
                  }
                } else {
                  let player = AVPlayer(url: URL(string: "https://i.electrics01.com/i/" + galleryItem.attachment)!)
                  VideoPlayer(player: player)
                    .onAppear {
                      player.play()
                    }
                }
              } else if galleryItem.type == "binary" {
                Image(systemName: "doc.zipper").resizable().aspectRatio(contentMode: .fit).frame(width: 84, height: 84).font(.largeTitle).padding(38)
              } else if galleryItem.type == "text" {
                Image(systemName: "doc.plaintext").resizable().aspectRatio(contentMode: .fit).frame(width: 84, height: 84).font(.largeTitle).padding(38)
              }
            }
            .frame(
              minWidth: 0,
              maxWidth: .infinity
            )
            Text("Type: " + (galleryItem.type))
            Text("Upload name: " + (galleryItem.attachment))
            if let date = inputDateFormatter.date(from: galleryItem.createdAt) {
              let formattedDate = outputDateFormatter.string(from: date)
              Text("Created at: " + formattedDate)
            } else {
              Text("Created at: Invalid Date")
            }
            Text("Size: " + formatFileSize(galleryItem.fileSize))
            HStack {
              Button("Copy Link") {
                #if os(iOS)
                UIPasteboard.general.setValue("https://i.electrics01.com/i/" + galleryItem.attachment,
                                              forPasteboardType: UTType.plainText.identifier)
                #elseif os(macOS)
                NSPasteboard.general.clearContents(); NSPasteboard.general.setString("https://i.electrics01.com/i/" + galleryItem.attachment, forType: .string)
                #endif
              }
              Button("Open image") {
                openURL(URL(string: "https://i.electrics01.com/i/" + galleryItem.attachment)!)
              }
              Button("Download") {
                let downloadTask = URLSession.shared.downloadTask(with: URL(string: "https://i.electrics01.com/i/" + galleryItem.attachment)!) { location, _, error in
                  guard let location = location else {
                    if let error = error {
                      print("Download failed with error: \(error.localizedDescription)")
                    }
                    return
                  }
                  do {
                    let documentsDirectory = FileManager.default.urls(for: .downloadsDirectory, in: .userDomainMask).first!
                    let destinationURL = documentsDirectory.appendingPathComponent(galleryItem.attachment)
                    try FileManager.default.moveItem(at: location, to: destinationURL)
                    print("File downloaded successfully and moved to \(destinationURL)")
                  } catch {
                    print("Error moving file: \(error.localizedDescription)")
                  }
                }
                downloadTask.resume()
              }
              Button("Delete") {
                Network.shared.apollo.perform(mutation: DeleteUploadsMutation(input: DeleteUploadInput(items: [Double(galleryItem.id)]))) { result in
                  switch result {
                  case .success:
                    galleryItems.remove(at: galleryItems.firstIndex(of: galleryItem)!)
                  case .failure(let error):
                    print("Failure! Error: \(error)")
                  }
                }
              }
            }
          }
          .padding()
          .frame(minWidth: 300, minHeight: 300)
          .background()
          .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
        }
      }
      .padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10))
      HStack {
        Text("Pages: " + String(galleryData?.pager.totalPages ?? 0))
        Button("Last Page") {
          currentPage -= 1
          getGallery()
        }
        .disabled(currentPage < 2)
        Button("Next Page") {
          currentPage += 1
          getGallery()
        }
        .disabled(currentPage >= galleryData?.pager.totalPages ?? 0)
        Text("Page: " + String(currentPage))
      }
      .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
    }
    .navigationTitle("Gallery")
    .onAppear {
      getGallery()
    }
  }
}
