//
//  LoginService.swift
//  LMD
//
//  Created by Naif on 25/02/1447 AH.
//
import Foundation

final class LoginService: LoginServiceProtocol {
    
    func login(request: LoginRequest) async throws -> LoginResponse {
        try await NetworkManager.shared.request(
            endpoint: .login,
            body: request,
            headers: nil
        )
    }
}
