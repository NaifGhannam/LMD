//
//  MyOrdersSerivceProtocol.swift
//  LMD
//
//  Created by Tahani on 25/02/1447 AH.
//

import Foundation

protocol MyOrdersServiceProtocol {
    
    func getMyOrders(page:Int , limit:Int) async throws -> OrdersResponse
    func updateOrderStatues(orderId: String, statusId: Int, assignedAgentId: String?) async throws -> OrderStatusUpdateResponse
    func getAllUsers() async throws -> UsersResponse
}
