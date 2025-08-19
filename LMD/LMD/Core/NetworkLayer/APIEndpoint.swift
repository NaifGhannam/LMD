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
        return "https://zvutnjtnjwvtyntcyfcc.supabase.co"
    }
    
    var path: String {
        switch self {
        case .login:
            return "/login"
            
        case .getUserOrders(let id):
            return "/functions/v1/user-orders/\(id)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .login: return .post
            
        case .getUserOrders:
            return .get
        }
    }
    
    var url: String {
        return authBaseURL + path
    }
}
