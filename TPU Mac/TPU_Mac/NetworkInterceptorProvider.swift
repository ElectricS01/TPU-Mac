//
//  NetworkInterceptorProvider.swift
//  TPU Mac
//
//  Created by ElectricS01  on 9/10/2023.
//

import Apollo
import ApolloAPI
import Foundation
import KeychainSwift

class AuthorizationInterceptor: ApolloInterceptor {
  public var id: String = UUID().uuidString

  func interceptAsync<Operation>(
    chain: RequestChain,
    request: HTTPRequest<Operation>,
    response: HTTPResponse<Operation>?,
    completion: @escaping (Result<GraphQLResult<Operation.Data>, Error>) -> Void
  ) where Operation: GraphQLOperation {
    if let token = KeychainSwift().get("token") {
      request.addHeader(name: "Authorization", value: token)
    }

    chain.proceedAsync(request: request,
                       response: response,
                       interceptor: self,
                       completion: completion)
  }
}

class NetworkInterceptorProvider: DefaultInterceptorProvider {
  override func interceptors<Operation>(for operation: Operation) -> [ApolloInterceptor] where Operation: GraphQLOperation {
    var interceptors = super.interceptors(for: operation)
    interceptors.insert(AuthorizationInterceptor(), at: 0)
    return interceptors
  }
}
