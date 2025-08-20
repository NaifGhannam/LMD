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
        return "https://wbyewodrizzecmhkcuil.supabase.co"
    }
    
    var path: String {
        switch self {
        case .login:
            return "/rest/v1/rpc/login_user"
        case .getUserOrders(let id):
            return "/rest/v1/orders?id=eq.\(id)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .login: return .post
        case .getUserOrders: return .get
        }
    }
    
    var url: String {
        return authBaseURL + path
    }
}
