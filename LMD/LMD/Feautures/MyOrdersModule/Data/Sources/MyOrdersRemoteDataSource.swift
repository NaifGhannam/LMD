//
//  MyOrdersRemoteDataSource.swift
//  LMD
//
//  Created by Tahani on 23/03/1447 AH.
//

import Foundation

struct MyOrdersRemoteDataSource {
    
    let client: NetworkClient
    
    func fetchOrders(page: Int, limit: Int) async throws -> OrdersResponse {
        try await client.request(endpoint: .getUserOrders(page: page, limit: limit), body: Optional<String>.none)
    }
    
    func updateOrder(orderId: String, statusId: Int, assignedAgentId: String?) async throws -> OrderStatusUpdateResponse {
        let req = OrderStatusUpdateRequest(orderID: orderId, statusID: statusId, assignedAgentId: assignedAgentId)
        return try await client.request(endpoint: .updateOrderStatues, body: req)
    }
    
    func fetchUsers() async throws -> UsersResponse {
        try await client.request(endpoint: .getAllUsers, body: Optional<String>.none)
    }
}

