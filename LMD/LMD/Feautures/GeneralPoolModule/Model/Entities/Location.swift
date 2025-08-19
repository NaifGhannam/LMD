//
//  Location.swift
//  LMD
//
//  Created by Tahani on 25/02/1447 AH.
//

import Foundation
import MapKit

struct Location: Identifiable, Equatable {
    
    let id = UUID().uuidString
    let customerName: String
    let orderNo: String
    let coordinates: CLLocationCoordinate2D
    
    static func == (lhs: Location, rhs: Location) -> Bool {
        return lhs.id == rhs.id
    }
}

