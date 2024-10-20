//
//  ContentView.swift
//  TPU Mac
//
//  Created by ElectricS01  on 6/10/2023.
//

import Apollo
import KeychainSwift
import PrivateUploaderAPI
import SwiftUI

let keychain = KeychainSwift()

enum DateUtils {
  static let dateFormat: (String?) -> String = { date in
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
    if let date = formatter.date(from: date ?? "") {
      formatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
      return formatter.string(from: date)
    } else {
      return "Invalid Date"
    }
  }

  static let relativeFormat: (String?) -> String = { date in
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
    if let date = formatter.date(from: date ?? "") {
      let formatter = RelativeDateTimeFormatter()
      formatter.unitsStyle = .full
      return formatter.localizedString(for: date, relativeTo: Date.now)
    } else {
      return "Invalid Date"
    }
  }
}

class Store: ObservableObject {
  @Published var coreState: StateQuery.Data.CoreState?
  @Published var coreUser: StateQuery.Data.CurrentUser?
  @Published var coreUsers: [StateQuery.Data.TrackedUser]?
}

struct ContentView: View {
  @StateObject var store = Store()
  @State private var showingLogin = keychain.get("token") == nil || keychain.get("token") == ""
  @State private var coreNotifications: [StateQuery.Data.CurrentUser.Notification]?
  @State var isPopover = false

  func getState() {
    Network.shared.apollo.fetch(query: StateQuery(), cachePolicy: .returnCacheDataAndFetch) { result in
      switch result {
      case .success(let graphQLResult):
        if let unwrapped = graphQLResult.data {
          store.coreState = unwrapped.coreState
          store.coreUser = unwrapped.currentUser
          coreNotifications = store.coreUser?.notifications
          store.coreUsers = unwrapped.trackedUsers
        }
      case .failure(let error):
        print("Failure! Error: \(error)")
      }
    }
  }

  func readNotifications() {
    Network.shared.apollo.perform(mutation: MarkNotificationsAsReadMutation()) { result in
      switch result {
      case .success(let graphQLResult):
        if let unwrapped = graphQLResult.data {
          coreNotifications = readToNotification(readObjects: unwrapped.markNotificationsAsRead)
        }
      case .failure(let error):
        print("Failure! Error: \(error)")
      }
    }
  }

  func readToNotification(readObjects: [MarkNotificationsAsReadMutation.Data.MarkNotificationsAsRead]) -> [StateQuery.Data.CurrentUser.Notification] {
    return readObjects.map { readObject in
      var notificationsData = DataDict(data: [:], fulfilledFragments: Set<ObjectIdentifier>())

      notificationsData["id"] = readObject.id
      notificationsData["dismissed"] = readObject.dismissed
      notificationsData["message"] = readObject.message
      notificationsData["route"] = readObject.route
      notificationsData["createdAt"] = readObject.createdAt

      return StateQuery.Data.CurrentUser.Notification(_dataDict: notificationsData)
    }
  }

  var body: some View {
    if showingLogin {
      LoginSheet(showingLogin: $showingLogin)
    } else {
      #if os(macOS)
        NavigationSplitView {
          List {
            NavigationLink(destination: HomeView()) {
              Label("Home", systemImage: "house")
            }
            NavigationLink(destination: SettingsView(showingLogin: $showingLogin)) {
              Label("Settings", systemImage: "gear")
            }
            NavigationLink(destination: GalleryView(stars: .constant(false), collectionId: .constant(nil), collectionName: .constant(nil))) {
              Label("Gallery", systemImage: "photo.on.rectangle")
            }
            NavigationLink(destination: GalleryView(stars: .constant(true), collectionId: .constant(nil), collectionName: .constant(nil))) {
              Label("Stars", systemImage: "star")
            }
            NavigationLink(destination: CollectionsView()) {
              Label("Collections", systemImage: "person.2.crop.square.stack.fill")
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
        }
        .onAppear {
          getState()
        }.environmentObject(store)
        .toolbar(id: "nav") {
          ToolbarItem(id: "bell") {
            Button(action: {
              isPopover.toggle()
            }) {
              Label("Notifications", systemImage: "bell")
              Text(String(coreNotifications?.filter { $0.dismissed == false }.count ?? 0))
            }.help("Notifications").popover(isPresented: $isPopover, arrowEdge: .bottom) {
              VStack {
                Text("Notifications").font(.title)
                ForEach(coreNotifications ?? [], id: \.self) { notification in
                  Divider()
                  HStack {
                    if !notification.dismissed {
                      Circle()
                        .fill(Color.accentColor)
                        .frame(width: 8, height: 8)
                    } else { Spacer().frame(width: 16) }
                    Text(notification.message)
                      .frame(maxWidth: 350, alignment: .topLeading)
                      .help(notification.message)
                    Text(DateUtils.relativeFormat(notification.createdAt)).font(.subheadline).foregroundStyle(.gray)
                  }.frame(maxWidth: .infinity, alignment: .leading).frame(alignment: .top)
                }
              }.padding()
            }.onChange(of: isPopover) { if !isPopover { readNotifications() } }
          }
        }
      #else
        TabView {
          HomeView().tabItem {
            Label("Home", systemImage: "house")
          }
          GalleryView(stars: .constant(false), collectionId: .constant(nil), collectionName: .constant(nil)).tabItem {
            Label("Gallery", systemImage: "photo.on.rectangle")
          }
          CollectionsView().tabItem {
            Label("Collections", systemImage: "person.2.crop.square.stack.fill")
          }
          CommsView().tabItem {
            Label("Comms", systemImage: "message")
          }
          SettingsView(showingLogin: $showingLogin).tabItem {
            Label("Settings", systemImage: "gear")
          }
        }
        .onAppear {
          getState()
        }.environmentObject(store)
      #endif
    }
  }
}

struct LoginSheet: View {
  @Binding var showingLogin: Bool
  @State private var username: String = ""
  @State private var password: String = ""
  @State private var totp: String = ""
  @State private var errorMessage = ""

  func loginDetails() {
    Network.shared.apollo.perform(mutation: LoginMutation(input: LoginInput(username: username, password: password, totp: GraphQLNullable(stringLiteral: totp)))) { result in
      switch result {
      case .success(let graphQLResult):
        if graphQLResult.errors?[0].message == nil {
          keychain.set(graphQLResult.data?.login.token ?? "", forKey: "token")
          showingLogin = false
          return
        }
        errorMessage = graphQLResult.errors?[0].localizedDescription ?? "Error"
      case .failure(let error):
        print("Failure! Error: \(error)")
        errorMessage = error.localizedDescription
      }
    }
  }

  var body: some View {
    VStack {
      Text("Login").font(.title)
      TextField("Username", text: $username)
        .onSubmit {
          loginDetails()
        }
        .frame(width: 200)
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .fixedSize(horizontal: true, vertical: false)
      SecureField("Password", text: $password)
        .onSubmit {
          loginDetails()
        }
        .frame(width: 200)
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .fixedSize(horizontal: true, vertical: false)
      TextField("2FA code", text: $totp)
        .onSubmit {
          loginDetails()
        }
        .frame(width: 200)
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .fixedSize(horizontal: true, vertical: false)
      Button("Login") {
        loginDetails()
      }
      Text(errorMessage)
        .foregroundColor(.red)
        .multilineTextAlignment(.center)
        .lineLimit(4)
        .fixedSize(horizontal: false, vertical: true)
    }.padding()
  }
}

struct SettingsView: View {
  @Binding var showingLogin: Bool
  @EnvironmentObject var store: Store

  var body: some View {
    VStack {
      Text("Settings")
      #if os(macOS)
        Text("Coming soon")
      #else
        Text("TPU iOS").font(.system(size: 32, weight: .semibold))
        Text("Version " + (Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "") + " (20/10/2024)")
        Text("Made by ElectricS01")
        Text("[Give it a Star on GitHub](https://github.com/ElectricS01/TPU-Mac)")
      #endif
      Text("Logged in as " + (store.coreUser?.username ?? "Unknown"))
      Button("Log out") {
        keychain.delete("token")
        showingLogin = true
      }
      .navigationTitle("Settings")
    }
  }
}

struct AboutView: View {
  var body: some View {
    VStack {
      Text("About")
        .navigationTitle("About")
      Text("TPU Mac").font(.system(size: 32, weight: .semibold))
      Text("Version " + (Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "") + " (20/10/2024)")
      Text("Made by ElectricS01")
      Text("[Give it a Star on GitHub](https://github.com/ElectricS01/TPU-Mac)")
    }
  }
}

#Preview {
  ContentView()
}
