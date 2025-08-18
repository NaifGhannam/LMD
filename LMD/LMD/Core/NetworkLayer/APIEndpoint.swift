//
//  APIEndpoint.swift
//  LMD
//
//  Created by Naif on 24/02/1447 AH.
//



import Foundation

enum APIEndpoint {
    case login

    var authBaseURL: String {
        return "https://zvutnjtnjwvtyntcyfcc.supabase.co"
    }

    var path: String {
        switch self {
        case .login:
            return "/login"

        }
    }

    var method: HTTPMethod {
        switch self {
        case .login: return .post
        
        }
    }

    var url: String {
        return authBaseURL + path
    }
}
