//
//  MyOrdersSerivce.swift
//  LMD
//
//  Created by Tahani on 25/02/1447 AH.
//

import Foundation

struct MyOrdersService: MyOrdersServiceProtocol {
    
    func getMyOrders(id: Int) async throws -> OrdersResponse {
        return try await NetworkManager.shared.request(endpoint: .getUserOrders(id: id))
    }
}
