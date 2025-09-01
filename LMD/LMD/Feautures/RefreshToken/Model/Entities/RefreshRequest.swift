//
//  RefreshRequest.swift
//  LMD
//
//  Created by Tahani on 09/03/1447 AH.
//

import Foundation

struct RefreshRequest: Codable {
    
    let refreshToken: String
    
    enum CodingKeys: String, CodingKey {
        case refreshToken = "refresh_token"
    }
}
