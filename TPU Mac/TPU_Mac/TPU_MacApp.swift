//
//  TPU_MacApp.swift
//  TPU Mac
//
//  Created by ElectricS01  on 6/10/2023.
//

import PrivateUploaderAPI
import SwiftUI

@main
struct TPU_MacApp: App {
  var body: some Scene {
    WindowGroup {
      ContentView()
    }
  }
}

struct ProfilePicture: View {
  var avatar: String
  var size: CGFloat

  var body: some View {
    if avatar.count < 21 {
      CacheAsyncImage(
        url: URL(string: "https://i.electrics01.com/i/" + avatar)
      ) { image in
        image.resizable()
      } placeholder: {
        ProgressView()
      }
      .frame(width: size, height: size)
      .cornerRadius(size / 2)
    } else {
      Image(systemName: "person.crop.circle").frame(width: size, height: size).font(.largeTitle)
    }
  }
}
