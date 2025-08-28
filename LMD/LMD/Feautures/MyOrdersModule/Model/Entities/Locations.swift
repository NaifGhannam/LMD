//
//  Locations.swift
//  LMD
//
//  Created by Tahani on 05/03/1447 AH.
//

import Foundation

struct Locations: Codable {
    
    let latitude: Double?
    let longitude: Double?
    let distanceCalculated: Double?
    let radiusApplied: Double?

    enum CodingKeys: String, CodingKey {
        case latitude, longitude
        case distanceCalculated = "distance_calculated"
        case radiusApplied = "radius_applied"
    }
}
