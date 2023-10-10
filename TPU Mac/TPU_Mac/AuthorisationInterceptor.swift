//
//  AuthorisationInterceptor.swift
//  TPU Mac
//
//  Created by ElectricS01  on 9/10/2023.
//

import Foundation
import Apollo
import KeychainSwift
import ApolloAPI

class AuthorizationInterceptor: ApolloInterceptor {
    // Any custom interceptors you use are required to be able to identify themselves through an id property.
    public var id: String = UUID().uuidString

    func interceptAsync<Operation>(
        chain: RequestChain,
        request: HTTPRequest<Operation>,
        response: HTTPResponse<Operation>?,
        completion: @escaping (Result<GraphQLResult<Operation.Data>, Error>) -> Void
    ) where Operation : GraphQLOperation {
        let keychain = KeychainSwift()
        if let token = keychain.get("token") {
            request.addHeader(name: "Authorization", value: token)
        }

        chain.proceedAsync(request: request,
                           response: response,
                           interceptor: self,
                           completion: completion)
    }
}
