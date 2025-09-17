//
//  LoginUseCase.swift
//  LMD
//
//  Created by Naif on 24/03/1447 AH.
//


struct LoginUseCase {
    private let repository: AuthRepository
    init(repository: AuthRepository) { self.repository = repository }

    func execute(email: String, password: String) async throws -> AuthSession {
        try await repository.login(email: email, password: password)
    }
}


