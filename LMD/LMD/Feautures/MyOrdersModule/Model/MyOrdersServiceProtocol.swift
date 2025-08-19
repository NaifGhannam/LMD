//
//  MyOrdersSerivceProtocol.swift
//  LMD
//
//  Created by Tahani on 25/02/1447 AH.
//

import Foundation

protocol MyOrdersServiceProtocol {
    
    func getMyOrders(id: Int) async throws -> OrdersResponse
}
