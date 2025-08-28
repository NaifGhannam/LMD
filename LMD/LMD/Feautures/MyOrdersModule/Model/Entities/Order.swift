//
//  Order.swift
//  LMD
//
//  Created by Tahani on 25/02/1447 AH.
//

import Foundation

struct Order: Codable {
    
    let orderID: String
    let orderNumber: String
    let customerID: String
    let customerName: String
    let address: String
    let statusID: Int
    let assignedAgentID: String
    let partnerID: String?
    let dcID: String?
    let orderDate: String
    let deliveryTime: String
    let slaMet: String?
    let serialNumber: String
    let coordinates: Coordinates
    let lastUpdated: String
    let orderStatuses: OrderStatus
    let users: Login
    let partners: String?
    let distributionCenters: String?
    let distanceKm: Double?

    enum CodingKeys: String, CodingKey {
        case orderID = "order_id"
        case orderNumber = "order_number"
        case customerID = "customer_id"
        case customerName = "customer_name"
        case address
        case statusID = "status_id"
        case assignedAgentID = "assigned_agent_id"
        case partnerID = "partner_id"
        case dcID = "dc_id"
        case orderDate = "order_date"
        case deliveryTime = "delivery_time"
        case slaMet = "sla_met"
        case serialNumber = "serial_number"
        case coordinates
        case lastUpdated = "last_updated"
        case orderStatuses = "orderstatuses"
        case users
        case partners
        case distributionCenters = "distributioncenters"
        case distanceKm = "distance_km"
    }
}

