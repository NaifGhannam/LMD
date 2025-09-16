//
//  AuthRepositoryImpl.swift
//  LMD
//
//  Created by Naif on 24/03/1447 AH.
//

final class AuthRepositoryImpl: AuthRepository {
    private let remote = AuthRemoteDataSource()

    func login(email: String, password: String) async throws -> AuthSession {
        let dto = LoginRequestDTO(email: email, password: password)

        let response = try await remote.login(request: dto)

        guard let session = response.toDomain() else {
            throw NetworkError.decodingFailed
        }

        return session
    }

    func logout() async throws -> Bool {
        try await remote.logout()
    }
}
