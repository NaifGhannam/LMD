//
//  LoginResponse.swift
//  LMD
//
//  Created by Naif on 24/02/1447 AH.
//

struct LoginResponse: Codable {
    let success: Bool
    let message: String
    let user: User
}

struct User: Codable {
    let user_id: String
    let username: String
    let email: String
    let mobile_number: String
    let role: String
    let created_at: String
}
