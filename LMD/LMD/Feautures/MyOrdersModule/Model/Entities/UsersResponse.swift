//
//  UsersResponse.swift
//  LMD
//
//  Created by Tahani on 05/03/1447 AH.
//

import Foundation

struct UsersResponse: Codable {
    
    let success: Bool
    let data: [Users]
    let totalCount: Int
    let currentUserID: String

    enum CodingKeys: String, CodingKey {
        case success
        case data
        case totalCount = "total_count"
        case currentUserID = "current_user_id"
    }
}

struct Users: Codable, Identifiable {
    
    let id: String
    let name: String
}
