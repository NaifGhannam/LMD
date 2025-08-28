//
//  MyOrdersSerivce.swift
//  LMD
//
//  Created by Tahani on 25/02/1447 AH.
//

import Foundation

struct MyOrdersService: MyOrdersServiceProtocol {
    
    func getMyOrders() async throws -> OrdersResponse {
        
        return try await NetworkManager.shared.request(endpoint: .getUserOrders)
    }
    
    func updateOrderStatues(orderId: String, statusId: Int) async throws -> OrderStatusUpdateResponse {
        
        let request = OrderStatusUpdateRequest(orderID: orderId, statusID: statusId)
        
        return try await NetworkManager.shared.request(endpoint: .updateOrderStatues, body: request)
    }
    
    func getAllUsers() async throws -> UsersResponse {
        
        return try await NetworkManager.shared.request(endpoint: .getAllUsers)
    }
}
