//
//  Friends.swift
//  TPU Mac
//
//  Created by ElectricS01  on 11/5/2026.
//

import PrivateUploaderAPI

@MainActor
func updateFriend(friendId: Int, action: FriendAction) {
  Network.shared.apollo.perform(mutation: FriendMutation(input: AddFriendInput(userId: GraphQLNullable<Int>(integerLiteral: friendId), action: GraphQLNullable<GraphQLEnum<FriendAction>>(action)))) { result in
    switch result {
    case .success:
      print("Friend updated")
    case let .failure(error):
      print(error)
    }
  }
}
