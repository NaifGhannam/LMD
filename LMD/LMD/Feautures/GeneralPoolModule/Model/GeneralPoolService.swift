//
//  GeneralPoolService.swift
//  LMD
//
//  Created by Naif on 09/03/1447 AH.
//

struct GeneralPoolService : GeneralPoolServiceProtocol {
    func getGeneralPool() async throws -> OrderResponse {
        return try await NetworkManager.shared.request(endpoint: .generalPool)
    }
    
    
}
