//
//  LoginRequestDTO.swift
//  LMD
//
//  Created by Naif on 24/03/1447 AH.
//

struct LoginRequestDTO: Codable {
    let email: String
    let password: String
}

struct LoginResponseDTO: Codable {
    let success: Bool
    let data: LoginDataDTO?
}

struct LoginDataDTO: Codable {
    let user: UserDTO
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

struct UserDTO: Codable {
    let id: String
    let email: String
    let fullName: String

    enum CodingKeys: String, CodingKey {
        case id, email
        case fullName = "full_name"
    }

    func toDomain() -> User {
        User(id: id, email: email, fullName: fullName)
    }
}
extension LoginResponseDTO {
    func toDomain() -> AuthSession? {
        guard let data = data else { return nil }
        return data.toDomain()
    }
}

extension LoginDataDTO {
    func toDomain() -> AuthSession {
        AuthSession(
            user: user.toDomain(),
            accessToken: accessToken,
            refreshToken: refreshToken,
            expiresAt: expiresAt,
            refreshExpiresAt: refreshExpiresAt
        )
    }
}


struct AuthSession {
    let user: User
    let accessToken: String
    let refreshToken: String
    let expiresAt: String
    let refreshExpiresAt: String
}
