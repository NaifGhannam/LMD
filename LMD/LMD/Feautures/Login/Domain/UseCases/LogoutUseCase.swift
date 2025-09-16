//
//  LogoutUseCase.swift
//  LMD
//
//  Created by Naif on 24/03/1447 AH.
//

struct LogoutUseCase {
    private let repository: AuthRepository
    init(repository: AuthRepository) { self.repository = repository }

    func execute() async throws -> Bool {
        try await repository.logout()
    }
}
