//
//  NetworkError.swift
//  LMD
//
//  Created by Naif on 24/02/1447 AH.
//
import Foundation

enum NetworkError: Error, LocalizedError {
    
    case invalidURL
    case requestFailed(Int)
    case decodingFailed
    case unknown
    case custom(String)
    case missingRefreshToken
    case refreshFailed(Int)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL."
        case .requestFailed(let statusCode):
            return "Request failed with status code \(statusCode)."
        case .decodingFailed:
            return "Failed to decode response."
        case .unknown:
            return "An unknown error occurred."
        case .custom(let message):
            return message
        case .missingRefreshToken:
            return "Missing refresh token."
        case .refreshFailed(let code):
            return "Token refresh failed with status \(code)."
        }
    }
}
