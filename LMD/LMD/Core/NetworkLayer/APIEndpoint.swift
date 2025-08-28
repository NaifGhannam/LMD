//
//  APIEndpoint.swift
//  LMD
//
//  Created by Naif on 24/02/1447 AH.
//

import Foundation

enum APIEndpoint {
    case login
    case getUserOrders(id: Int)
    
    var authBaseURL: String {
        "https://kgomwyksxjqtcjwlzbsp.supabase.co/functions/v1/"
    }
    
    var path: String {
        switch self {
        case .login: return "login"
        case .getUserOrders(let id): return "/rest/v1/orders?id=eq.\(id)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .login: return .post
        case .getUserOrders: return .get
        }
    }
    
    var requiresAuth: Bool {
        switch self {
        case .login: return false
        case .getUserOrders: return true
        }
    }
    
    var url: String { authBaseURL + path }
}
