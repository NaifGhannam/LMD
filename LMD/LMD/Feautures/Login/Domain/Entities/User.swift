//
//  User.swift
//  LMD
//
//  Created by Naif on 24/03/1447 AH.
//


// Domain/Entities/User.swift
struct User: Codable, Equatable {
    let id: String
    let email: String
    let fullName: String
}
