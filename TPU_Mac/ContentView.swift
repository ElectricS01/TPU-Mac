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
  @Binding var selection: Destination
  @StateObject var store = Store()
  @State private var showingLogin = keychain.get("token") == nil || keychain.get("token") == ""
  @State private var showingTerms = false
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
          showingTerms = !(unwrapped.currentUser?.privacyPolicyAccepted ?? false)
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

  func acceptTerms() {
    Network.shared.apollo.perform(mutation: UpdateUserMutation(input: UpdateUserInput(privacyPolicyAccepted: true))) { result in
      switch result {
      case .success:
        showingTerms = false
      case .failure(let error):
        print("Failure! Error: \(error)")
      }
    }
  }

  var body: some View {
    if showingLogin {
      LoginSheet(showingLogin: $showingLogin)
    } else {
      #if os(macOS)
      NavigationSplitView {
        List(selection: $selection) {
          NavigationLink(value: Destination.home) {
            Label("Home", systemImage: "house")
          }
          NavigationLink(value: Destination.settings) {
            Label("Settings", systemImage: "gear")
          }
          NavigationLink(value: Destination.gallery) {
            Label("Gallery", systemImage: "photo.on.rectangle")
          }
          NavigationLink(value: Destination.stars) {
            Label("Stars", systemImage: "star")
          }
          NavigationLink(value: Destination.collections) {
            Label("Collections", systemImage: "person.2.crop.square.stack.fill")
          }
          NavigationLink(value: Destination.comms) {
            Label("Comms", systemImage: "message")
          }
          NavigationLink(value: Destination.about) {
            Label("About", systemImage: "info.circle")
          }
        }
        .navigationTitle("Menu")
      } detail: {
        switch selection {
        case .home:
          HomeView()
        case .settings:
          SettingsView(showingLogin: $showingLogin)
        case .gallery:
          GalleryView(stars: .constant(false), collectionId: .constant(nil), collectionName: .constant(nil))
        case .stars:
          GalleryView(stars: .constant(true), collectionId: .constant(nil), collectionName: .constant(nil))
        case .collections:
          CollectionsView()
        case .comms:
          CommsView()
        case .about:
          AboutView()
        }
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
            Text(String(coreNotifications?.filter { !$0.dismissed }.count ?? 0))
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
                }
              }
            }.padding()
          }.onChange(of: isPopover) { if !isPopover { readNotifications() } }
        }
      }
      .sheet(isPresented: $showingTerms) {
        VStack {
          Text("The Privacy Policy has been updated").font(.system(size: 24, weight: .semibold)).padding()
          Text("Please accept the [Privacy Policy](https://www.flowinity.com/privacy.html)").padding()
          Button("Accept") {
            acceptTerms()
          }.padding()
        }.interactiveDismissDisabled()
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
      .sheet(isPresented: $showingTerms) {
        VStack {
          Text("The Privacy Policy has been updated").font(.system(size: 24, weight: .semibold)).padding()
          Text("Please accept the [Privacy Policy](https://www.flowinity.com/privacy.html)").padding()
          Button("Accept") {
            acceptTerms()
          }.padding()
        }.interactiveDismissDisabled()
      }
      #endif
    }
  }
}

struct LoginSheet: View {
  @Binding var showingLogin: Bool
  @State private var email: String = ""
  @State private var username: String = ""
  @State private var password: String = ""
  @State private var retype: String = ""
  @State private var totp: String = ""
  @State private var agreeTerms = false
  @State private var errorMessage = ""
  @State private var registerPage = false

  func loginDetails() {
    if username.isEmpty {
      errorMessage = "Please enter a username"
      return
    }

    if password.isEmpty {
      errorMessage = "Please enter a password"
      return
    }

    errorMessage = ""

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

  func registerDetails() {
    if email.isEmpty {
      errorMessage = "Please enter an email"
      return
    }

    if username.isEmpty {
      errorMessage = "Please enter a username"
      return
    }

    if password.isEmpty {
      errorMessage = "Please enter a password"
      return
    }

    if password != retype {
      errorMessage = "Passwords do not match"
      return
    }

    if !agreeTerms {
      errorMessage = "Please agree to the terms and conditions"
      return
    }

    errorMessage = ""

    Network.shared.apollo.perform(mutation: RegisterMutation(input: RegisterInput(username: username, password: password, email: email))) { result in
      switch result {
      case .success(let graphQLResult):
        if graphQLResult.errors?[0].message == nil {
          keychain.set(graphQLResult.data?.register.token ?? "", forKey: "token")
          showingLogin = false
          return
        }

        if let message = graphQLResult.errors?[0].localizedDescription {
          if message == "Argument Validation Error" {
            errorMessage = "An input is blank or incorrect"
            print(graphQLResult)
            return
          }

          errorMessage = message
          return
        }

        errorMessage = "An unknown error occurred"
      case .failure(let error):
        print("Failure! Error: \(error)")
        errorMessage = error.localizedDescription
      }
    }
  }

  var body: some View {
    VStack {
      if registerPage == false {
        Text("Login").font(.largeTitle)
        TextField("Username", text: $username)
          .onSubmit {
            loginDetails()
          }
          .frame(width: 300)
          .textFieldStyle(RoundedBorderTextFieldStyle())
          .fixedSize(horizontal: true, vertical: false)
        SecureField("Password", text: $password)
          .onSubmit {
            loginDetails()
          }
          .frame(width: 300)
          .textFieldStyle(RoundedBorderTextFieldStyle())
          .fixedSize(horizontal: true, vertical: false)
        TextField("2FA code", text: $totp)
          .onSubmit {
            loginDetails()
          }
          .frame(width: 300)
          .textFieldStyle(RoundedBorderTextFieldStyle())
          .fixedSize(horizontal: true, vertical: false)
        ZStack {
          HStack {
            Spacer()
            Button("Or register") {
              registerPage = true
              username = ""
              password = ""
              totp = ""
              errorMessage = ""
            }
            #if os(macOS)
            .buttonStyle(.link)
            #endif
          }

          Button("Login") {
            loginDetails()
          }
          .padding()
        }.frame(width: 300)
      } else {
        Text("Register").font(.largeTitle)
        TextField("Email", text: $email)
          .onSubmit {
            registerDetails()
          }
        #if !os(macOS)
          .keyboardType(.emailAddress)
        #endif
          .frame(width: 300)
          .textFieldStyle(RoundedBorderTextFieldStyle())
          .fixedSize(horizontal: true, vertical: false)
        TextField("Username", text: $username)
          .onSubmit {
            registerDetails()
          }
          .frame(width: 300)
          .textFieldStyle(RoundedBorderTextFieldStyle())
          .fixedSize(horizontal: true, vertical: false)
        SecureField("Password", text: $password)
          .onSubmit {
            registerDetails()
          }
          .frame(width: 300)
          .textFieldStyle(RoundedBorderTextFieldStyle())
        SecureField("Retype Password", text: $retype)
          .onSubmit {
            registerDetails()
          }
          .frame(width: 300)
          .textFieldStyle(RoundedBorderTextFieldStyle())
          .fixedSize(horizontal: true, vertical: false)
          .fixedSize(horizontal: true, vertical: false)
        Toggle(isOn: $agreeTerms) {
          Text("I agree to the [Content Policy](https://www.flowinity.com/policies/content) and the [Privacy Policy](https://www.flowinity.com/policies/privacy)")
        }
        ZStack {
          HStack {
            Spacer()
            Button("Back to login") {
              registerPage = false
              email = ""
              username = ""
              password = ""
              retype = ""
              agreeTerms = false
              errorMessage = ""
            }
            #if os(macOS)
            .buttonStyle(.link)
            #endif
          }

          Button("Register") {
            registerDetails()
          }
          .padding()
        }.frame(width: 300)
      }

      Text(errorMessage)
        .foregroundColor(.red)
        .multilineTextAlignment(.center)
        .lineLimit(4)
        .fixedSize(horizontal: false, vertical: true)
        .textSelection(.enabled)
    }.padding()
  }
}

struct AboutView: View {
  var body: some View {
    VStack {
      Text("About")
        .navigationTitle("About")
      Text("TPU Mac").font(.system(size: 32, weight: .semibold))
      Text("Version " + (Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "") + " (6/10/2025)")
      Text("Made by ElectricS01")
      Text("[Give it a Star on GitHub](https://github.com/ElectricS01/TPU-Mac)")
    }
  }
}

#Preview {
  ContentView(selection: .constant(.home))
}
