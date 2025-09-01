//
//  OrdersResponse.swift
//  LMD
//
//  Created by Naif on 09/03/1447 AH.
//


import Foundation

// MARK: - Root
struct OrderResponse: Codable {
    let success: Bool
    let data: OrdersDatas
}

// MARK: - Data
struct OrdersDatas: Codable {
    let initialOrders: [Order]
    let pagination: Pagination
    let realtimeConfig: RealtimeConfig
    let subscriptionID: String
    let channelName: String
    let filtersApplied: FiltersApplied
    let userOrdersOnly: Bool
    let locationFilter: String?
    let userInfo: UserInfo
    let instructions: Instructions

    enum CodingKeys: String, CodingKey {
        case initialOrders = "initial_orders"
        case pagination
        case realtimeConfig = "realtime_config"
        case subscriptionID = "subscription_id"
        case channelName = "channel_name"
        case filtersApplied = "filters_applied"
        case userOrdersOnly = "user_orders_only"
        case locationFilter = "location_filter"
        case userInfo = "user_info"
        case instructions
    }
}

// MARK: - Pagination
struct Pagination: Codable {
    let currentPage, totalPages, totalCount, limit, offset: Int
    let hasNextPage, hasPrevPage: Bool
    let showingFrom, showingTo: Int

    enum CodingKeys: String, CodingKey {
        case currentPage = "current_page"
        case totalPages = "total_pages"
        case totalCount = "total_count"
        case limit, offset
        case hasNextPage = "has_next_page"
        case hasPrevPage = "has_prev_page"
        case showingFrom = "showing_from"
        case showingTo = "showing_to"
    }
}

// MARK: - RealtimeConfig
struct RealtimeConfig: Codable {
    let channelName: String
    let userID: String
    let filters: FiltersApplied
    let userOrdersOnly: Bool
    let subscriptionConfig: SubscriptionConfig

    enum CodingKeys: String, CodingKey {
        case channelName = "channel_name"
        case userID = "user_id"
        case filters
        case userOrdersOnly = "user_orders_only"
        case subscriptionConfig = "subscription_config"
    }
}

// MARK: - FiltersApplied
struct FiltersApplied: Codable {
    let statusID: String?
    let customerName: String?
    let orderNumber: String?
    let assignedAgentID: String?
    let partnerID: String?
    let dcID: String?
    let search: String?

    enum CodingKeys: String, CodingKey {
        case statusID = "status_id"
        case customerName = "customer_name"
        case orderNumber = "order_number"
        case assignedAgentID = "assigned_agent_id"
        case partnerID = "partner_id"
        case dcID = "dc_id"
        case search
    }
}

// MARK: - SubscriptionConfig
struct SubscriptionConfig: Codable {
    let table, event, schema: String
}

// MARK: - UserInfo
struct UserInfo: Codable {
    let id, email, fullName: String

    enum CodingKeys: String, CodingKey {
        case id, email
        case fullName = "full_name"
    }
}

// MARK: - Instructions
struct Instructions: Codable {
    let connectToChannel: String
    let listenForEvents: String
    let broadcastEvents: String
    let paginationUsage: String

    enum CodingKeys: String, CodingKey {
        case connectToChannel = "connect_to_channel"
        case listenForEvents = "listen_for_events"
        case broadcastEvents = "broadcast_events"
        case paginationUsage = "pagination_usage"
    }
}
