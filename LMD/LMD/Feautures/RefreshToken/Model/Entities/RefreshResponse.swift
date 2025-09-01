//
//  RefreshResponse.swift
//  LMD
//
//  Created by Tahani on 08/03/1447 AH.
//

import Foundation

struct RefreshResponse: Decodable {
    let success: Bool
    let data: RefreshData
}
