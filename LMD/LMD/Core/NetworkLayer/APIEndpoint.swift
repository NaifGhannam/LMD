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
    case generalPool
    case refreshToken
    
    var authBaseURL: String {
        return "https://kgomwyksxjqtcjwlzbsp.supabase.co/"
    }
    
    var path: String {
        switch self {
        case .login:
            return "functions/v1/login"
            
        case .getUserOrders:
            return "functions/v1/orders-list?page=6&limit=5"
            
        case .updateOrderStatues:
            return "functions/v1/update-order-status"
            
        case .getAllUsers:
            return "functions/v1/get-all-users"

        case .generalPool:
            return "functions/v1/live-orders?page=1&limit=10"
            
        case .refreshToken:
            return "functions/v1/refresh-token"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .login:
            return .post
            
        case .getUserOrders:
            return .get
            
        case .updateOrderStatues:
            return .post
            
        case .getAllUsers:
            return .get
            
        case .generalPool:
            return .get
            
        case .refreshToken:
            return .post

        }
    }
    
    var requiresAuth: Bool {
        switch self {
        case .login:
            return false
        
        case .getUserOrders:
            return true
        
        case .updateOrderStatues:
            return true
        
        case .getAllUsers:
            return true
            
        case .generalPool:
            return true

        case .refreshToken:
            return false
        }
    }
    
    var url: String { authBaseURL + path }
}
