//
//  OrdersStatus.swift
//  LMD
//
//  Created by Tahani on 05/03/1447 AH.
//

import Foundation

struct OrderStatus: Codable {
    
    let colorCode: String
    let statusName: String
    let fontColorCode: String

    enum CodingKeys: String, CodingKey {
        case colorCode = "color_code"
        case statusName = "status_name"
        case fontColorCode = "font_color_code"
    }
}
