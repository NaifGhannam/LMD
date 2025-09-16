//
//  AuthRepository.swift
//  LMD
//
//  Created by Naif on 24/03/1447 AH.
//

protocol AuthRepository {
    func login(email: String, password: String) async throws -> AuthSession
    func logout() async throws -> Bool
}
