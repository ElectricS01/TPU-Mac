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

struct ContentView: View {
  @State var showingLogin = false

  var body: some View {
    NavigationSplitView {
      List {
        NavigationLink(destination: HomeView(showingLogin: $showingLogin)
          .sheet(isPresented: $showingLogin) {
            LoginSheet()
          }) {
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

  func login(username: String, password: String, totp: String, completion: @escaping (Result<String, Error>) -> Void) {
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

  func loginDetails() {
    login(username: username, password: password, totp: totp) { result in
      switch result {
      case .success(let message):
        errorMessage = message
        if errorMessage == "Success" {
          dismiss()
        }
      case .failure(let error):
        errorMessage = error.localizedDescription
      }
    }
  }

  var body: some View {
    VStack {
      Text("Login")
        .font(.title)
      TextField(
        "Username",
        text: $username
      )
      .onSubmit {
        loginDetails()
      }
      .frame(width: 200)
      .textFieldStyle(RoundedBorderTextFieldStyle())
      .fixedSize(horizontal: true, vertical: false)
      SecureField(
        "Password",
        text: $password
      )
      .onSubmit {
        loginDetails()
      }
      .frame(width: 200)
      .textFieldStyle(RoundedBorderTextFieldStyle())
      .fixedSize(horizontal: true, vertical: false)
      TextField(
        "2FA code",
        text: $totp
      )
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

struct HomeView: View {
  @Binding var showingLogin: Bool

  var body: some View {
    Text("Welcome to TPU Mac")
      .navigationTitle("Home")
    Button("Backup Login") {
      showingLogin = true
    }
  }
}

struct SettingsView: View {
  var body: some View {
    Text("Settings")
    Text("Coming soon")
      .navigationTitle("Settings")
  }
}

struct AboutView: View {
  var body: some View {
    Text("About")
      .navigationTitle("About")
    #if os(macOS)
    Text("TPU Mac").font(.system(size: 24, weight: .semibold))
    #else
    Text("TPU iOS").font(.system(size: 24, weight: .semibold))
    #endif
    Text("Version 0.0.21 (8/2/2024)")
    Text("Made by ElectricS01")
    Text("[Give it a Star on GitHub](https://github.com/ElectricS01/TPU-Mac)")
  }
}

#Preview {
  ContentView()
}
