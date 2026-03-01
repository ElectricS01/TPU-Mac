//
//  AboutView.swift
//  TPU Mac
//
//  Created by ElectricS01  on 1/3/2026.
//

import SwiftUI

struct AboutView: View {
  var body: some View {
    VStack {
      Text("About").navigationTitle("About")
      Text("TPU Mac").font(.system(size: 32, weight: .semibold))
      Text("Version " + (Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "") + " (02/03/2026)")
      Text("Made by ElectricS01")
      Text("[Give it a Star on GitHub](https://github.com/ElectricS01/TPU-Mac)")
    }
  }
}
