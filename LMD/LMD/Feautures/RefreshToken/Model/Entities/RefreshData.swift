//
//  RefreshData.swift
//  LMD
//
//  Created by Tahani on 08/03/1447 AH.
//

import Foundation

struct RefreshData: Codable {
    
    let user: RefreshUser
    let accessToken: String
    let refreshToken: String
    let expiresAt: String
    
    enum CodingKeys: String, CodingKey {
        case user = "user"
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
        case expiresAt = "expires_at"
    }
}

