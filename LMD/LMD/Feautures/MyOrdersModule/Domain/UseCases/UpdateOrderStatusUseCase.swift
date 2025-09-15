//
//  UpdateOrderStatusUseCase.swift
//  LMD
//
//  Created by Tahani on 23/03/1447 AH.
//

import Foundation

protocol UpdateOrderStatusUseCase {
    func execute(orderId: String, statusId: Int, assignedAgentId: String?) async throws -> Bool
}

final class UpdateOrderStatus: UpdateOrderStatusUseCase {
    private let repo: MyOrdersRepository
    public init(repo: MyOrdersRepository) { self.repo = repo }
    public func execute(orderId: String, statusId: Int, assignedAgentId: String?) async throws -> Bool {
        try await repo.updateOrderStatus(orderId: orderId, statusId: statusId, assignedAgentId: assignedAgentId)
    }
}
