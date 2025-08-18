//
//  LoginResponse.swift
//  LMD
//
//  Created by Naif on 24/02/1447 AH.
//


struct LoginResponse: Codable {
    let success: Bool
    let user: User
    let tokens: Tokens
}

struct User: Codable {
    let id: String
    let email: String
    let role: String
}

struct Tokens: Codable {
    let access_token: String
    let refresh_token: String
}
