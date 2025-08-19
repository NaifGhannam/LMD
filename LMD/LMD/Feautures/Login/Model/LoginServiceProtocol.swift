//
//  LoginServiceProtocol.swift
//  LMD
//
//  Created by Naif on 25/02/1447 AH.
//

protocol LoginServiceProtocol {
    func login(email : String , password : String) async throws -> LoginResponse
}
