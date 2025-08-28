//
//  OrderStatusUpdateRequest.swift
//  LMD
//
//  Created by Tahani on 05/03/1447 AH.
//

import Foundation

struct OrderStatusUpdateRequest: Codable {
    
    let orderID: String
    let statusID: Int
    
    enum CodingKeys: String, CodingKey {
        case orderID = "order_id"
        case statusID = "status_id"
    }
}
