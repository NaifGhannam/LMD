//
//  Filters.swift
//  LMD
//
//  Created by Tahani on 05/03/1447 AH.
//

import Foundation

struct Filters: Codable {
    
    let statusIDs: String?
    let customerName: String?
    let orderNumber: String?
    let assignedAgentID: String?
    let partnerID: String?
    let dcID: String?
    let userOrdersOnly: Bool
    let search: String?
    let radiusKm: String?

    enum CodingKeys: String, CodingKey {
        case statusIDs = "status_ids"
        case customerName = "customer_name"
        case orderNumber = "order_number"
        case assignedAgentID = "assigned_agent_id"
        case partnerID = "partner_id"
        case dcID = "dc_id"
        case userOrdersOnly = "user_orders_only"
        case search
        case radiusKm = "radius_km"
    }
}
