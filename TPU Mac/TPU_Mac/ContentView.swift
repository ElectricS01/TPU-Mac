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

let keychain = KeychainSwift()

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

func chats(completion: @escaping (Result<GraphQLResult<ChatsQuery.Data>, Error>) -> Void) {
  Network.shared.apollo.fetch(query: ChatsQuery()) { result in
    switch result {
    case .success:
      completion(result)
    case .failure(let error):
      print("Failure! Error: \(error)")
      completion(result)
    }
  }
}

func messages(chat: Int, completion: @escaping (Result<GraphQLResult<MessagesQuery.Data>, Error>) -> Void) {
  Network.shared.apollo.fetch(query: MessagesQuery(input: InfiniteMessagesInput(associationId: chat, position: GraphQLNullable(ScrollPosition.top), limit: 50
                                                                               ))) { result in
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
  @State private var showingSheet = false
  
  var body: some View {
    NavigationSplitView {
      List {
        NavigationLink(destination: HomeView()) {
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
      HomeView()
        .sheet(isPresented: $showingSheet) {
          LoginSheet()
        }
    }
    .onAppear {
      showingSheet = keychain.get("token") == ""
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
  var body: some View {
    Text("Welcome to TPU Mac")
      .navigationTitle("Home")
    Button("Tap count: \(tapCount)") {
      tapCount += 1
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
  var body: some View {
    ScrollView {
      LazyVGrid(columns: [GridItem(.adaptive(minimum: 216))], spacing: 20) {
        ForEach(0..<galleryItems.count, id: \.self) { result in
          //            Button(action: {print(galleryItems[result].id)}) {
          //                Text(galleryItems[result].name ?? "Image")
          //            }
          AsyncImage(
            url: URL(string: "https://i.electrics01.com/i/" + galleryItems[result].attachment)
          ) { image in
            image.resizable()
          } placeholder: {
            ProgressView()
          }
          .frame(width: 200, height: 200)
          .cornerRadius(8)
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

struct CommsView: View {
  @State private var chatsList: [ChatsQuery.Data.Chat] = []
  @State private var chatMessages: [MessagesQuery.Data.Message] = []
  @State private var chatOpen: Int = 0
  
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
  
  func openChat (chatId: Int?) {
    messages(chat: chatId ?? 0) { result in
      switch result {
      case .success(let graphQLResult):
        if let unwrapped = graphQLResult.data {
          chatMessages = unwrapped.messages
          chatOpen = chatId ?? 0
        }
      case .failure(let error):
        print(error)
      }
    }
  }
  
  var body: some View {
    NavigationSplitView {
      List {
        ForEach(0..<chatsList.count, id: \.self) { result in
          Button(chatsList[result].recipient?.username ?? chatsList[result].name) {
            openChat(chatId: chatsList[result].association?.id)
          }
        }
      }
    } detail: {
      if chatOpen != 0 {
        ScrollViewReader { proxy in
          ScrollView {
            VStack(alignment: .leading, spacing: 6) {
              ForEach(chatMessages.reversed(), id: \.self) { message in
                HStack (alignment: .top, spacing: 6) {
                  if ((message.user?.avatar) != nil) {
                    AsyncImage(
                      url: URL(string: "https://i.electrics01.com/i/" + (message.user?.avatar ?? ""))
                    ) { image in
                      image.resizable()
                    } placeholder: {
                      ProgressView()
                    }
                    .frame(width: 32, height: 32)
                    .cornerRadius(16)
                  } else {
                    Image(systemName: "person.crop.circle").frame(width: 32, height: 32).font(.largeTitle)
                  }
                  VStack {
                    HStack {
                      Text(message.user?.username ?? "Error")
                      if let date = inputDateFormatter.date(from: message.createdAt) {
                        let formattedDate = outputDateFormatter.string(from: date)
                        Text(formattedDate)
                      } else {
                        Text("Invalid Date")
                      }
                    }.frame(minWidth: 0,
                            maxWidth: .infinity,
                            minHeight: 0,
                            maxHeight: 6,
                            alignment: .topLeading)
                    Text(message.content ?? "Error")
                      .frame(minWidth: 0,
                             maxWidth: .infinity,
                             minHeight: 0,
                             maxHeight: .infinity,
                             alignment: .topLeading)
                  }
                }.padding(4)
                  .id(message.id)
              }
            }.frame(
              minWidth: 0,
              maxWidth: .infinity,
              minHeight: 0,
              maxHeight: .infinity,
              alignment: .topLeading
            )
            .onAppear {
              if (chatMessages.count != 0) {
                proxy.scrollTo(chatMessages.first?.id)
              }
            }
            .onChange(of: chatMessages) {
              proxy.scrollTo(chatMessages.first?.id)
            }
          }
        }
      } else {
        Text("Comms")
      }
    }
    .navigationTitle("Comms")
    .onAppear {
      chats { result in
        switch result {
        case .success(let graphQLResult):
          if let unwrapped = graphQLResult.data {
            chatsList = unwrapped.chats
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

