//
//  LoginService.swift
//  LMD
//
//  Created by Naif on 25/02/1447 AH.
//

struct LoginService : LoginServiceProtocol {
    func login(email: String, password: String) async throws  -> LoginResponse {
        let request = LoginRequest(
            email: email,
            password: password     )
        
        return try await NetworkManager.shared.request(
            endpoint: .login,
            body: request
            )
        
    }
}
