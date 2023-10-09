//
//  AuthorisationInterceptor.swift
//  TPU Mac
//
//  Created by ElectricS01  on 9/10/2023.
//

import Foundation
import Apollo
import ApolloAPI
import KeychainSwift

class AuthorisationInterceptor: ApolloInterceptor {
    var id: String = ""
    
    
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
                            completion: completion)
    }
    
}
