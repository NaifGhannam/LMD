//
//  Pagination.swift
//  LMD
//
//  Created by Tahani on 05/03/1447 AH.
//

import Foundation

struct Paginations: Codable {
    
    let currentPage: Int
    let totalPages: Int
    let totalCount: Int
    let limit: Int
    let hasNextPage: Bool
    let hasPrevPage: Bool

    enum CodingKeys: String, CodingKey {
        case currentPage = "current_page"
        case totalPages = "total_pages"
        case totalCount = "total_count"
        case limit
        case hasNextPage = "has_next_page"
        case hasPrevPage = "has_prev_page"
    }
}
