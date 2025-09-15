//
//  Sorting.swift
//  LMD
//
//  Created by Tahani on 05/03/1447 AH.
//

import Foundation

struct Sorting: Codable {
    
    let sortBy: String
    let sortOrder: String

    enum CodingKeys: String, CodingKey {
        case sortBy = "sort_by"
        case sortOrder = "sort_order"
    }
}
