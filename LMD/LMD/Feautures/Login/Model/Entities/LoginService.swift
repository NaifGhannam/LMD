//
//  LoginService.swift
//  LMD
//
//  Created by Naif on 25/02/1447 AH.
//
struct LoginService : LoginServiceProtocol {
    func login(username: String, password: String) async throws -> LoginResponse {
        let request = LoginRequest(
            p_username: username,
            p_password: password
        )
        
        return try await NetworkManager.shared.request(
            endpoint: .login,
            body: request
        )
    }
}
