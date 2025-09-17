//
//  AuthRepositoryImpl.swift
//  LMD
//
//  Created by Naif on 24/03/1447 AH.
//

import Foundation

final class AuthRepositoryImpl: AuthRepository {
    func login(email: String, password: String) async throws -> AuthSession {
        let dto = LoginRequestDTO(email: email, password: password)

        let response: LoginResponseDTO = try await NetworkManager.shared.request(
            endpoint: .login,
            body: dto
        )

        guard let session = response.toDomain() else {
            throw NetworkError.decodingFailed
        }
        return session
    }

    func logout() async throws -> Bool {
        struct LogoutResponse: Decodable { let success: Bool }
        let response: LogoutResponse = try await NetworkManager.shared.request(
            endpoint: .Logout
        )
        return response.success
    }
}
