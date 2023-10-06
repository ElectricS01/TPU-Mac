//
//  ContentView.swift
//  TPU Mac
//
//  Created by ElectricS01  on 6/10/2023.
//

import SwiftUI
import Apollo

let apolloClient = ApolloClient(url: URL(string: "https://privateuploader.com/graphql")!)

let password = "password"
let username = "username"
let totp = 123456

struct TwoColumnSplitView: View {
    @AppStorage("tapCount") private var tapCount = 0
    
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
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("TPU Mac")
            Button("Tap count: \(tapCount)") {
                        tapCount += 1
                    }
            
        }
    }
}

struct HomeView: View {
    var body: some View {
        Text("Home")
            .navigationTitle("Home")
    }
}

struct SettingsView: View {
    var body: some View {
        Text("Settings")
            .navigationTitle("Settings")
    }
}

struct GalleryView: View {
    var body: some View {
        Text("Gallery")
            .navigationTitle("Gallery")
    }
}

struct CommsView: View {
    var body: some View {
        Text("Comms")
            .navigationTitle("Comms")
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
