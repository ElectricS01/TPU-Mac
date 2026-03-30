//
//  Network.swift
//  PrivateUploaderAPI
//
//  Created by ElectricS01  on 7/10/2023.
//

import Apollo
import ApolloSQLite
import ApolloWebSocket
import Foundation
import KeychainSwift

func temporarySQLite() -> SQLiteNormalizedCache? {
  let dbPath = NSSearchPathForDirectoriesInDomains(.applicationSupportDirectory, .userDomainMask, true).first! + "/com.electrics01.tpumac"

  if !FileManager.default.fileExists(atPath: dbPath) {
    try? FileManager.default.createDirectory(atPath: dbPath, withIntermediateDirectories: true, attributes: nil)
  }
  return try? SQLiteNormalizedCache(fileURL: URL(fileURLWithPath: dbPath).appendingPathComponent("db.sqlite3"))
}

@MainActor
class Network {
  static let shared = Network()

  let store = ApolloStore(cache: temporarySQLite() ?? InMemoryNormalizedCache())

  private lazy var webSocketTransport: WebSocketTransport = {
    let url = URL(string: "https://api.flowinity.com/graphql")!
    let authPayload = ["token": KeychainSwift().get("token")]
    let config = WebSocketTransport.Configuration(connectingPayload: authPayload)
    do {
      return try WebSocketTransport(urlSession: URLSession.shared,
                                    store: store,
                                    endpointURL: URL(string: "wss://example.com/graphql")!,
                                    configuration: config)
    } catch {
      fatalError("Failed to create WebSocketTransport: \(error)")
    }
  }()

  private lazy var httpTransport: RequestChainNetworkTransport = {
    let url = URL(string: "https://api.flowinity.com/graphql")!
    let provider = NetworkInterceptorProvider()
    return RequestChainNetworkTransport(urlSession: URLSession.shared, interceptorProvider: provider, store: store, endpointURL: url)
  }()

  private lazy var splitNetworkTransport = SplitNetworkTransport(
    queryTransport: self.httpTransport,
    mutationTransport: self.httpTransport,
    subscriptionTransport: self.webSocketTransport
  )

  private(set) lazy var apollo = ApolloClient(networkTransport: splitNetworkTransport, store: store)
}
