//
//  GeneralPoolServiceProtocol.swift
//  LMD
//
//  Created by Naif on 09/03/1447 AH.
//
import Foundation

protocol GeneralPoolServiceProtocol {
    func getGeneralPool() async throws -> OrderResponse
}
