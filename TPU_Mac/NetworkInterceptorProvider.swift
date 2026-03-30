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

final class AuthorizationInterceptor: HTTPInterceptor {
  func intercept(request: URLRequest, next: NextHTTPInterceptorFunction) async throws -> HTTPResponse {
    var modifiedRequest = request

    if let token = KeychainSwift().get("token") {
      modifiedRequest.addValue(token, forHTTPHeaderField: "Authorization")
    }

    return try await next(modifiedRequest)
  }
}

struct NetworkInterceptorProvider: InterceptorProvider {

    func httpInterceptors<Operation: GraphQLOperation>(for operation: Operation) -> [any HTTPInterceptor] {
        return [AuthorizationInterceptor()] + DefaultInterceptorProvider.shared.httpInterceptors(for: operation)
    }

}
