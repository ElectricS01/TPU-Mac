//
//  UserSheetView.swift
//  TPU Mac
//
//  Created by ElectricS01  on 26/3/2026.
//

import NukeUI
import PrivateUploaderAPI
import SwiftUI

struct UserSheetView: View {
  let user: StateQuery.Data.TrackedUser
  @State private var profile: UserProfileQuery.Data.User?
  @State private var loading = false

  func getUserProfile(id: Int) {
    Network.shared.apollo.fetch(query: UserProfileQuery(input: UserProfileInput(id: GraphQLNullable<Int>(integerLiteral: id))), cachePolicy: .returnCacheDataAndFetch) { result in
      switch result {
      case let .success(graphQLResult):
        if let unwrapped = graphQLResult.data {
          profile = unwrapped.user
          loading = false
        }
      case let .failure(error):
        print("Failure! Error: \(error)")
      }
    }
  }

  var body: some View {
    VStack {
      if loading {
        ProgressView()
      } else if let profile {
        LazyImage(url: URL(string: "https://i.electrics01.com/i/" + String(profile.banner ?? "d81dabf74c88.png"))) { state in
          if let image = state.image {
            image.resizable().interpolation(.high).antialiased(true).aspectRatio(contentMode: .fill)
          } else if state.error != nil {
            Color.red
          } else {
            ProgressView()
          }
        }
        .frame(width: 400, height: 60).clipped()
        VStack {
          HStack {
            ProfileStatus(avatar: user.avatar, status: user.status.value ?? .offline)
            Text(user.username)
          }
          Text(profile.description ?? "No description")
        }.padding()
      }
    }
    .frame(width: 400, height: 300, alignment: .top)
    .onAppear {
      getUserProfile(id: user.id)
    }
  }
}
