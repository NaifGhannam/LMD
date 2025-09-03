//
//  MyOrdersSerivce.swift
//  LMD
//
//  Created by Tahani on 25/02/1447 AH.
//
//
import Foundation

struct MyOrdersService: MyOrdersServiceProtocol {
    
    func getMyOrders(page: Int, limit: Int) async throws -> OrdersResponse {
        let endpoint = APIEndpoint.getUserOrders(page: page, limit: limit)
        return try await NetworkManager.shared.request(endpoint: endpoint)
    }
    
    func updateOrderStatues(orderId: String, statusId: Int, assignedAgentId: String?) async throws -> OrderStatusUpdateResponse {
        let request = OrderStatusUpdateRequest(orderID: orderId, statusID: statusId, assignedAgentId: assignedAgentId)
        return try await NetworkManager.shared.request(endpoint: .updateOrderStatues, body: request)
    }
    
    func getAllUsers() async throws -> UsersResponse {
        return try await NetworkManager.shared.request(endpoint: .getAllUsers)
    }
}
