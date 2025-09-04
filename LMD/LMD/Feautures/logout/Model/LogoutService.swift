//
//  LogoutService.swift
//  LMD
//
//  Created by Naif on 12/03/1447 AH.
//


import Foundation

final class LogoutService: LogoutServiceProtocol {
    func logout() async throws -> Bool {
        let response: LogoutResponse = try await NetworkManager.shared.request(
            endpoint: .Logout,
            body: nil,
            headers: nil
        )
        return response.success
    }
}
