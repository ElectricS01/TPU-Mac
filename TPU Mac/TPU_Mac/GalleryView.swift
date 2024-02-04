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
  @State private var galleryItems: [GalleryItemsQuery.Data.Gallery.Item] = []
  @State private var isPlaying: Int = -1
  @State private var page: Int = 1

  func gallery(completion: @escaping (Result<GraphQLResult<GalleryItemsQuery.Data>, Error>) -> Void) {
    Network.shared.apollo.fetch(query: GalleryItemsQuery(input: GalleryInput(InputDict(["page": page, "limit": 30]))), cachePolicy: .fetchIgnoringCacheData) { result in
      switch result {
      case .success:
        completion(result)
      case .failure(let error):
        print("Failure! Error: \(error)")
        completion(result)
      }
    }
  }

  var body: some View {
    ScrollView {
      LazyVGrid(columns: [GridItem(.adaptive(minimum: 316))], spacing: 20) {
        ForEach(galleryItems, id: \.self) { galleryItem in
          VStack(alignment: .leading) {
            Text(galleryItem.name ?? "Unknown").font(.title2)
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
                .frame(minWidth: 268, maxWidth: .infinity, minHeight: 140, maxHeight: 140)
              } else if galleryItem.type == "video" {
                if isPlaying != galleryItem.id {
                  Button(action: {
                    if isPlaying == galleryItem.id {
                      isPlaying = -1
                    } else {
                      isPlaying = galleryItem.id
                    }
                  }) {
                    Image(systemName: "play.circle.fill")
                      .resizable()
                      .frame(width: 112, height: 112)
                      .foregroundColor(.white)
                  }
                }
                if isPlaying == galleryItem.id {
                  let player = AVPlayer(url: URL(string: "https://i.electrics01.com/i/" + galleryItem.attachment)!)
                  VideoPlayer(player: player)
                    .onAppear {
                      player.play()
                    }
                }
              } else if galleryItem.type == "binary" {
                Image(systemName: "doc.zipper").resizable().aspectRatio(contentMode: .fit).frame(width: 64, height: 64).font(.largeTitle).padding(38)
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
              Button(action: {
                #if os(iOS)
                UIPasteboard.general.setValue("https://i.electrics01.com/i/" + galleryItem.attachment,
                                              forPasteboardType: UTType.plainText.identifier)
                #elseif os(macOS)
                NSPasteboard.general.clearContents(); NSPasteboard.general.setString("https://i.electrics01.com/i/" + galleryItem.attachment, forType: .string)
                #endif
              }) {
                Text("Copy Link")
              }
              Button(action: {
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
              }) {
                Text("Download file")
              }
              Button(action: {
                Network.shared.apollo.perform(mutation: DeleteUploadsMutation(input: DeleteUploadInput(items: [Double(galleryItem.id)]))) { result in
                  switch result {
                  case .success(let graphQLResult):
                    print(graphQLResult)
                    galleryItems.remove(at: galleryItems.firstIndex(of: galleryItem)!)
                  case .failure(let error):
                    print("Failure! Error: \(error)")
                  }
                }
              }) {
                Text("Delete")
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
        Button(action: {
          page -= 1
          gallery { result in
            switch result {
            case .success(let graphQLResult):
              if let unwrapped = graphQLResult.data {
                galleryItems = unwrapped.gallery.items
              }
            case .failure(let error):
              print(error)
            }
          }
        }) {
          Text("Last Page")
        }
        .disabled(page < 2)
        Button(action: {
          page += 1
          gallery { result in
            switch result {
            case .success(let graphQLResult):
              if let unwrapped = graphQLResult.data {
                galleryItems = unwrapped.gallery.items
              }
            case .failure(let error):
              print(error)
            }
          }
        }) {
          Text("Next Page")
        }
      }
      .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
    }
    .navigationTitle("Gallery")
    .onAppear {
      gallery { result in
        switch result {
        case .success(let graphQLResult):
          if let unwrapped = graphQLResult.data {
            galleryItems = unwrapped.gallery.items
          }
        case .failure(let error):
          print(error)
        }
      }
    }
  }
}
