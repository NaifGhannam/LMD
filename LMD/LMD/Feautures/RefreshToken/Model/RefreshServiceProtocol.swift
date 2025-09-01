//
//  RefreshServiceProtocol.swift
//  LMD
//
//  Created by Tahani on 09/03/1447 AH.
//

import Foundation

protocol RefreshServiceProtocol {
    func refreshToken(refreshToken: String) async throws -> RefreshResponse
}
