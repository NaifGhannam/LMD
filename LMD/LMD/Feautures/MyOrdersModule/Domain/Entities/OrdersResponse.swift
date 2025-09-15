//
//  OrdersResponse.swift
//  LMD
//
//  Created by Tahani on 25/02/1447 AH.
//

import Foundation

struct OrdersResponse: Codable {
    
    let success: Bool
    let data: OrdersData
}
