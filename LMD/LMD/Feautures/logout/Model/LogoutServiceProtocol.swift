//
//  LogoutServiceProtocol.swift
//  LMD
//
//  Created by Naif on 12/03/1447 AH.
//


import Foundation

protocol LogoutServiceProtocol {
    func logout() async throws -> Bool
}
