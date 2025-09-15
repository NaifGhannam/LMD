//
//  Users.swift
//  LMD
//
//  Created by Tahani on 05/03/1447 AH.
//

import Foundation

struct Login: Codable {
    
    let id: String
    let email: String
    let fullName: String

    enum CodingKeys: String, CodingKey {
        case id, email
        case fullName = "full_name"
    }
}
