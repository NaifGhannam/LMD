//
//  RefreshService.swift
//  LMD
//
//  Created by Tahani on 09/03/1447 AH.
//

import Foundation

struct RefreshService: RefreshServiceProtocol {
    
    func refreshToken(refreshToken: String) async throws -> RefreshResponse {
        
        let request = RefreshRequest(refreshToken: refreshToken)
        return try await NetworkManager.shared.request(endpoint: .refreshToken, body: request)
    }
}
