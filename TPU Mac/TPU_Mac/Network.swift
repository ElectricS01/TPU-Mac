//
//  Network.swift
//  PrivateUploaderAPI
//
//  Created by ElectricS01  on 7/10/2023.
//

import Apollo
import ApolloWebSocket
import Foundation
import KeychainSwift

class Network {
  static let shared = Network()
  let store = ApolloStore(cache: InMemoryNormalizedCache())

  private lazy var webSocketTransport: WebSocketTransport = {
    let url = URL(string: "https://privateuploader.com/graphql")!
    let webSocketClient = WebSocket(url: url, protocol: .graphql_transport_ws)
    let authPayload = ["token": KeychainSwift().get("token")]
    let config = WebSocketTransport.Configuration(connectingPayload: authPayload)
    let transport = WebSocketTransport(websocket: webSocketClient, config: config)

    return transport
  }()

  private lazy var httpTransport: UploadingNetworkTransport = {
    let url = URL(string: "https://privateuploader.com/graphql")!
    let provider = NetworkInterceptorProvider(client: URLSessionClient(), store: store)
    let transport = RequestChainNetworkTransport(interceptorProvider: provider, endpointURL: url)

    return transport
  }()

  private lazy var splitNetworkTransport = SplitNetworkTransport(
    uploadingNetworkTransport: self.httpTransport,
    webSocketNetworkTransport: self.webSocketTransport
  )

  private(set) lazy var apollo = ApolloClient(networkTransport: splitNetworkTransport, store: store)
}
