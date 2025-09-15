//
//  OrderStatusUpdateResponse.swift
//  LMD
//
//  Created by Tahani on 05/03/1447 AH.
//

import Foundation

struct OrderStatusUpdateResponse: Codable {
    
    let success: Bool
    let message: String
    let data: OrderData
    let updatedBy: UpdatedBy

    enum CodingKeys: String, CodingKey {
        case success
        case message
        case data
        case updatedBy = "updated_by"
    }
}

struct OrderData: Codable {
    
    let orderID: String
    let orderNumber: String
    let statusID: Int
    let assignedAgentID: String
    let lastUpdated: String
    let customerName: String
    let address: String
    let orderStatuses: OrderStatuses
    let assignedAgent: AssignedAgent
    let previousStatusID: Int
    let statusChanged: Bool

    enum CodingKeys: String, CodingKey {
        case orderID = "order_id"
        case orderNumber = "order_number"
        case statusID = "status_id"
        case assignedAgentID = "assigned_agent_id"
        case lastUpdated = "last_updated"
        case customerName = "customer_name"
        case address
        case orderStatuses = "orderstatuses"
        case assignedAgent = "assigned_agent"
        case previousStatusID = "previous_status_id"
        case statusChanged = "status_changed"
    }
}

struct OrderStatuses: Codable {
    
    let colorCode: String
    let statusName: String
    let fontColorCode: String

    enum CodingKeys: String, CodingKey {
        case colorCode = "color_code"
        case statusName = "status_name"
        case fontColorCode = "font_color_code"
    }
}

struct AssignedAgent: Codable {
    
    let id: String
    let email: String
    let fullName: String

    enum CodingKeys: String, CodingKey {
        case id
        case email
        case fullName = "full_name"
    }
}

struct UpdatedBy: Codable {
    
    let userID: String
    let email: String
    let fullName: String

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case email
        case fullName = "full_name"
    }
}
