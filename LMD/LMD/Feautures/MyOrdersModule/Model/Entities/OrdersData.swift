//
//  OrdersData.swift
//  LMD
//
//  Created by Tahani on 05/03/1447 AH.
//

import Foundation

struct OrdersData: Codable {
    
    let orders: [Order]
    let pagination: Paginations
    let filters: Filters
    let location: Locations
    let sorting: Sorting
}
