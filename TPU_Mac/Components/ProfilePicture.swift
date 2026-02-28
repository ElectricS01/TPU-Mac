//
//  ProfilePicture.swift
//  TPU Mac
//
//  Created by ElectricS01  on 27/2/2026.
//

import NukeUI
import SwiftUI

struct ProfilePicture: View {
  var avatar: String?
  var size: CGFloat = 32

  var body: some View {
    if let avatar = avatar, avatar.count < 21 {
      LazyImage(url: URL(string: "https://i.electrics01.com/i/" + avatar)) { state in
        if let image = state.image {
          image.resizable().interpolation(.high).antialiased(true).aspectRatio(contentMode: .fill)
        } else if state.error != nil {
          Color.red
        } else {
          ProgressView()
        }
      }
      .frame(width: size, height: size)
      .cornerRadius(size / 2)
    } else {
      Image(systemName: "person.crop.circle").frame(width: size, height: size).font(.system(size: CGFloat(size)))
    }
  }
}
