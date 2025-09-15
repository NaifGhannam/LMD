//
//  GetAllUsersUseCase.swift
//  LMD
//
//  Created by Tahani on 23/03/1447 AH.
//

import Foundation

protocol GetAllUsersUseCase {
    func execute() async throws -> [Users]
}

final class GetAllUsers: GetAllUsersUseCase {
    private let repo: MyOrdersRepository
    public init(repo: MyOrdersRepository) { self.repo = repo }
    public func execute() async throws -> [Users] { try await repo.getAllUsers() }
}
