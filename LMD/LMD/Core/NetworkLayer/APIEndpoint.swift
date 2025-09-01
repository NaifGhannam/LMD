//
//  APIEndpoint.swift
//  LMD
//
//  Created by Naif on 24/02/1447 AH.
//

import Foundation

enum APIEndpoint {
    
    case login
    case getUserOrders
    case updateOrderStatues
    case getAllUsers
    case refreshToken
    
    var authBaseURL: String {
        return "https://kgomwyksxjqtcjwlzbsp.supabase.co/"
    }
    
    var path: String {
        switch self {
        case .login:
            return "/rest/v1/rpc/login_user"
            
        case .getUserOrders:
            return "functions/v1/orders-list?page=6&limit=5"
            
        case .updateOrderStatues:
            return "functions/v1/update-order-status"
            
        case .getAllUsers:
            return "functions/v1/get-all-users"
            
        case .refreshToken:
            return "functions/v1/refresh-token"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .login: return .post
            
        case .getUserOrders:
            return .get
            
        case .updateOrderStatues:
            return .post
            
        case .getAllUsers:
            return .get
            
        case .refreshToken:
            return .post
        }
    }
    
    var url: String {
        return authBaseURL + path
    }
}
