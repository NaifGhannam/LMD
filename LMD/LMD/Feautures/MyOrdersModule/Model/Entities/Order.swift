//
//  Order.swift
//  LMD
//
//  Created by Tahani on 25/02/1447 AH.
//

import Foundation

struct Order: Codable, Identifiable {
    
    let orderId: Int
    let orderNumber: String
    let orderDate: String
    let status: OrderStatus
    let customerName: String
    let address: String

    var id: Int { orderId }
}
