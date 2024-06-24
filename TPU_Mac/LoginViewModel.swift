//
//  LoginViewModel.swift
//  TPU Mac
//
//  Created by ElectricS01  on 7/10/2023.
//

import Foundation
import Apollo
import PrivateUploaderAPI

@MainActor
final class LoginViewModel: ObservableObject {
    init() {
        Network.shared.apollo.perform(mutation: LoginMutation(input: LoginInput(username: "e", password: "eee", totp: "e"))) { result in
            switch result {
            case .success(let graphQLResult):
                print("Success! Result: \(graphQLResult)")
            case .failure(let error):
                print("Failure! Error: \(error)")
            }
        }
    }
}
