//
//  NetworkClient.swift
//  LMD
//
//  Created by Tahani on 23/03/1447 AH.
//

import Foundation

protocol NetworkClient {
    func request<T: Decodable>(endpoint: APIEndpoint, body: Encodable?) async throws -> T
}

final class DefaultNetworkClient: NetworkClient {
    public init() {}
    public func request<T: Decodable>(endpoint: APIEndpoint, body: Encodable? = nil) async throws -> T {
        try await NetworkManager.shared.request(endpoint: endpoint, body: body)
    }
}
