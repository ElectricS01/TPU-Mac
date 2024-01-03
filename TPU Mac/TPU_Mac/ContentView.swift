//
//  ContentView.swift
//  TPU Mac
//
//  Created by ElectricS01  on 6/10/2023.
//

import SwiftUI
import Apollo
import PrivateUploaderAPI
import KeychainSwift
import AVKit

let keychain = KeychainSwift()

let inputDateFormatter: DateFormatter = {
  let formatter = DateFormatter()
  formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
  return formatter
}()

let outputDateFormatter: DateFormatter = {
  let formatter = DateFormatter()
  formatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
  return formatter
}()

func formatFileSize(_ size: Double) -> String {
  let byteCountFormatter = ByteCountFormatter()
  byteCountFormatter.allowedUnits = [.useKB, .useMB, .useGB]
  byteCountFormatter.countStyle = .file
  return byteCountFormatter.string(fromByteCount: Int64(size)) 
}

func login(username:String,password:String,totp:String, completion: @escaping (Result<String, Error>) -> Void) {
  Network.shared.apollo.perform(mutation: LoginMutation(input: LoginInput(username: username, password: password, totp: GraphQLNullable(stringLiteral: totp)))) { result in
    switch result {
    case .success(let graphQLResult):
      completion(.success(graphQLResult.errors?[0].message ?? "Success"))
      keychain.set(graphQLResult.data?.login.token ?? "", forKey: "token")
    case .failure(let error):
      print("Failure! Error: \(error)")
      completion(.failure(error))
    }
  }
}

func gallery(completion: @escaping (Result<GraphQLResult<GalleryItemsQuery.Data>, Error>) -> Void) {
  Network.shared.apollo.fetch(query: GalleryItemsQuery(input: GalleryInput(InputDict()))) { result in
    switch result {
    case .success:
      completion(result)
    case .failure(let error):
      print("Failure! Error: \(error)")
      completion(result)
    }
  }
}

struct TwoColumnSplitView: View {
  @AppStorage("tapCount") private var tapCount = 0
  @AppStorage("token") var token = ""
  @State var showingLogin = false
  
  var body: some View {
    NavigationSplitView {
      List {
        NavigationLink(destination: HomeView(showingLogin: $showingLogin)) {
          Label("Home", systemImage: "house")
        }
        NavigationLink(destination: SettingsView()) {
          Label("Settings", systemImage: "gear")
        }
        NavigationLink(destination: GalleryView()) {
          Label("Gallery", systemImage: "photo.on.rectangle")
        }
        NavigationLink(destination: CommsView()) {
          Label("Comms", systemImage: "message")
        }
        NavigationLink(destination: AboutView()) {
          Label("About", systemImage: "info.circle")
        }
      }
    } detail: {
      HomeView(showingLogin: $showingLogin)
        .sheet(isPresented: $showingLogin) {
          LoginSheet()
        }
    }
    .onAppear {
      showingLogin = (keychain.get("token") == nil || keychain.get("token") == "")
    }
  }
}

struct LoginSheet: View {
  @Environment(\.dismiss) var dismiss
  @State private var username: String = ""
  @State private var password: String = ""
  @State private var totp: String = ""
  @State private var errorMessage = ""
  
  func login () {
    TPU_Mac.login(username: username, password: password, totp: totp) { result in
      switch result {
      case .success(let message):
        errorMessage = message
        if errorMessage == "Success"{
          dismiss()
        }
      case .failure(let error):
        errorMessage = error.localizedDescription
      }}
  }
  
  var body: some View {
    VStack{
      Text("Login")
        .font(.title)
      TextField(
        "Username",
        text: $username
      )
      .onSubmit {
        login()
      }
      .frame(width: 200)
      .textFieldStyle(RoundedBorderTextFieldStyle())
      .fixedSize(horizontal: true, vertical: false)
      SecureField (
        "Password",
        text: $password
      )
      .onSubmit {
        login()
      }
      .frame(width: 200)
      .textFieldStyle(RoundedBorderTextFieldStyle())
      .fixedSize(horizontal: true, vertical: false)
      TextField(
        "2FA code",
        text: $totp
      )
      .onSubmit {
        login()
      }
      .frame(width: 200)
      .textFieldStyle(RoundedBorderTextFieldStyle())
      .fixedSize(horizontal: true, vertical: false)
      Button("Login") {
        login()
      }
      Text(errorMessage)
        .foregroundColor(.red)
        .multilineTextAlignment(.center)
        .lineLimit(4)
        .fixedSize(horizontal: false, vertical: true)
    }.padding()
  }
}

struct HomeView: View {
  @AppStorage("tapCount") private var tapCount = 0
  @Binding var showingLogin: Bool
  
  var body: some View {
    Text("Welcome to TPU Mac")
      .navigationTitle("Home")
    Button("Tap count: \(tapCount)") {
      tapCount += 1
    }
    Button("Login") {
      showingLogin = true
    }
    Button("Req") {
      gallery() { result in
        switch result {
        case .success(let message):
          print(message.data?.gallery.items.count ?? message)
          print("eee")
          print(message.errors?[0].message ?? message)
        case .failure(let error):
          print(error.localizedDescription)
        }
      }
    }
  }
}

struct SettingsView: View {
  var body: some View {
    Text("Settings")
      .navigationTitle("Settings")
  }
}

struct GalleryView: View {
  @State private var galleryItems: [GalleryItemsQuery.Data.Gallery.Item] = []
  @State private var isPlaying: Int = -1
  
  var body: some View {
    ScrollView {
      LazyVGrid(columns: [GridItem(.adaptive(minimum: 316))], spacing: 20) {
        ForEach(galleryItems, id: \.self) { galleryItem in
          VStack (alignment: .leading) {
            Text(galleryItem.name ?? "Unknown").font(.title2)
            HStack (alignment: .center) {
              if (galleryItem.type == "image") {
                AsyncImage(
                  url: URL(string: "https://i.electrics01.com/i/" + galleryItem.attachment)
                ) { image in
                  image.resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 268, height: 168)
                } placeholder: {
                  ProgressView()
                }
              } else if (galleryItem.type == "video") {
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
                      .frame(width: 140, height: 140)
                      .foregroundColor(.white)
                  }
                }
                if isPlaying == galleryItem.id {
                  let player = AVPlayer(url: URL(string: "https://i.electrics01.com/i/" + galleryItem.attachment)!)
                  VideoPlayer(player: player)
                    .onAppear() {
                      player.play()
                    }
                }
              }
            }
            .frame(
              minWidth: 0,
              maxWidth: .infinity
            )
            Text("Type: " + (galleryItem.type ))
            Text("Upload name: " + (galleryItem.attachment ))
            if let date = inputDateFormatter.date(from: galleryItem.createdAt) {
              let formattedDate = outputDateFormatter.string(from: date)
              Text("Created at: " + formattedDate)
            } else {
              Text("Created at: Invalid Date")
            }
            Text("Size: " + (formatFileSize(galleryItem.fileSize )))
          }
          .padding()
          .frame(width: 300, height: 300)
          .background()
          .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
        }
      }
    }
    Text("Gallery")
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

struct AboutView: View {
  var body: some View {
    Text("About")
      .navigationTitle("About")
    Text("TPU Mac version 0.0.2 (3/1/2024)")
  }
}

struct ContentView: View {
  var body: some View {
    TwoColumnSplitView()
  }
}

#Preview {
  ContentView()
}

