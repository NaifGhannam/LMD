//
//  Location.swift
//  LMD
//
//  Created by Tahani on 25/02/1447 AH.
//

import CoreLocation

extension Order: Identifiable {
    var id: String { orderID }
}

extension Order {
    var coordinate2D: CLLocationCoordinate2D {
        .init(latitude: coordinates.latitude, longitude: coordinates.longitude)
    }
}

