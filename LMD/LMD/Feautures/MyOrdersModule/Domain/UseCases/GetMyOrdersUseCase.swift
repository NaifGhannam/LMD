//
//  GetMyOrdersUseCase.swift
//  LMD
//
//  Created by Tahani on 23/03/1447 AH.
//

import Foundation

protocol GetMyOrdersUseCase {
    func execute(page: Int, limit: Int) async throws -> (orders: [Order], data: OrdersData, pagination: Paginations?)
}

final class GetMyOrders: GetMyOrdersUseCase {
    
    private let repo: MyOrdersRepository
    
    public init(repo: MyOrdersRepository) { self.repo = repo }
    
    public func execute(page: Int, limit: Int) async throws -> (orders: [Order], data: OrdersData, pagination: Paginations?) {
        try await repo.getMyOrders(page: page, limit: limit)
    }
}
