//
//  LoginResponse.swift
//  LMD
//
//  Created by Naif on 24/02/1447 AH.
//

// MARK: - LoginResponse
struct LoginResponse: Codable {
    let success: Bool
    let data: LoginData?
}

// MARK: - LoginData
struct LoginData: Codable {
    let user: User
    let accessToken: String
    let refreshToken: String
    let expiresAt: String
    let refreshExpiresAt: String

    enum CodingKeys: String, CodingKey {
        case user
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
        case expiresAt = "expires_at"
        case refreshExpiresAt = "refresh_expires_at"
    }
}

// MARK: - User
struct User: Codable {
    let id: String
    let email: String
    let fullName: String

    enum CodingKeys: String, CodingKey {
        case id, email
        case fullName = "full_name"
    }
}
