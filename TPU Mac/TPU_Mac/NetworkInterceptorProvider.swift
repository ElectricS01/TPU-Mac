//
//  NetworkInterceptorProvider.swift
//  TPU Mac
//
//  Created by ElectricS01  on 9/10/2023.
//

import Foundation
import Apollo
import ApolloAPI

class NetworkInterceptorProvider: DefaultInterceptorProvider {
    
    override func interceptors<Operation>(for operation: Operation) -> [ApolloInterceptor] where Operation : GraphQLOperation {
        var interceptors = super.interceptors(for: operation)
        interceptors.insert(AuthorisationInterceptor(), at: 0)
        return interceptors
    }
    
}
