//
//  LoginServiceProtocol.swift
//  LMD
//
//  Created by Naif on 25/02/1447 AH.
//
import Foundation

protocol LoginServiceProtocol {
    func login(request: LoginRequest) async throws -> LoginResponse
}
