//
//  MyOrdersRepositoryImpl.swift
//  LMD
//
//  Created by Tahani on 23/03/1447 AH.
//

import Foundation

final class MyOrdersRepositoryImpl: MyOrdersRepository {
    
    private let remote: MyOrdersRemoteDataSource

    public init(remote: MyOrdersRemoteDataSource) {
        self.remote = remote
    }

    public func getMyOrders(page: Int, limit: Int)
    async throws -> (orders: [Order], data: OrdersData, pagination: Paginations?) {
        let dto = try await remote.fetchOrders(page: page, limit: limit)
        return dto.data.toDomain()
    }

    public func updateOrderStatus(orderId: String, statusId: Int, assignedAgentId: String?)
    async throws -> Bool {
        let dto = try await remote.updateOrder(orderId: orderId, statusId: statusId, assignedAgentId: assignedAgentId)
        return dto.success
    }

    public func getAllUsers() async throws -> [Users] {
        let dto = try await remote.fetchUsers()
        return dto.data.map { $0.toDomain() }
    }
}

