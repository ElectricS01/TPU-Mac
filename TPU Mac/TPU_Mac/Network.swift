//
//  Network.swift
//  PrivateUploaderAPI
//
//  Created by ElectricS01  on 7/10/2023.
//

import Foundation
import Apollo

class Network {
  static let shared = Network()

  private init() {}

  private(set) lazy var apollo = ApolloClient(url: URL(string: "https://privateuploader.com/graphql")!)
}
