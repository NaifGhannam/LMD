//
//  MyOrdersSerivceProtocol.swift
//  LMD
//
//  Created by Tahani on 25/02/1447 AH.
//

import Foundation

protocol MyOrdersServiceProtocol {
    
    func getMyOrders() async throws -> OrdersResponse
    func updateOrderStatues(orderId: String, statusId: Int) async throws -> OrderStatusUpdateResponse
    func getAllUsers() async throws -> UsersResponse
}
