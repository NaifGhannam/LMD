//
//  MyOrdersRepository.swift
//  LMD
//
//  Created by Tahani on 23/03/1447 AH.
//

import Foundation

protocol MyOrdersRepository {
    
    func getMyOrders(page: Int, limit: Int) async throws -> (orders: [Order], data: OrdersData, pagination: Paginations?)
    func updateOrderStatus(orderId: String, statusId: Int, assignedAgentId: String?) async throws -> Bool
    func getAllUsers() async throws -> [Users]
}
