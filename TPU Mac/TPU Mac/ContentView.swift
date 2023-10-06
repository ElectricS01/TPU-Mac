//
//  ContentView.swift
//  TPU Mac
//
//  Created by ElectricS01  on 6/10/2023.
//

import SwiftUI

struct MenuItem: Identifiable, Hashable {
    let name: String
    let id = UUID()
}


private var oceans = [
    MenuItem(name: "Home"),
    MenuItem(name: "Settings"),
    MenuItem(name: "Gallery"),
    MenuItem(name: "Comms"),
    MenuItem(name: "Skill issue")
]

struct TwoColumnSplitView: View {
    
    @State private var selectedCategoryId: MenuItem.ID?
    
    var body: some View {
        NavigationSplitView {
            List(oceans) { ocean in
                HStack {
                    
                    Text(ocean.name)
                        .font(.system(.title3, design: .rounded))
                        .bold()
                }
            }
        } detail: {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("BetterTPU tbh")
            
        }
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
