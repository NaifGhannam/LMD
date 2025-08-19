//
//  GeneralPoolViewModel.swift
//  LMD
//
//  Created by Tahani on 25/02/1447 AH.
//

import SwiftUI
import MapKit

class GeneralPoolViewModel: ObservableObject {
    
    @Published var locations: [Location]
    @Published var mapLocation: Location {
        didSet {
            updateMapRegion(location: mapLocation)
        }
    }
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    
    init() {
        let locations = LocationsDataService.locations
        self.locations = locations
        self.mapLocation = locations.first!
        self.updateMapRegion(location: locations.first!)
        
    }
    
    private func updateMapRegion(location: Location) {
        withAnimation {
            mapRegion = MKCoordinateRegion(center: location.coordinates, span: mapSpan)
        }
    }
    
    func showNextLocation(location: Location) {
        withAnimation(.easeInOut) {
            mapLocation = location
        }
    }
}

class LocationsDataService {
    
    static let locations: [Location] = [
        Location(
            customerName: "Faisal Al Saud",
            orderNo: "304567",
            coordinates: CLLocationCoordinate2D(latitude: 24.7136, longitude: 46.6753) // Riyadh, Saudi Arabia
        ),
        Location(
            customerName: "Ahmed Khaled",
            orderNo: "102345",
            coordinates: CLLocationCoordinate2D(latitude: 30.0444, longitude: 31.2357) // Cairo, Egypt
        ),
        Location(
            customerName: "Sara Mohamed",
            orderNo: "203456",
            coordinates: CLLocationCoordinate2D(latitude: 29.9792, longitude: 31.1342) // Giza Pyramids, Egypt
        ),
        Location(
            customerName: "Noura Al Rashid",
            orderNo: "405678",
            coordinates: CLLocationCoordinate2D(latitude: 21.4858, longitude: 39.1925) // Jeddah, Saudi Arabia
        )
    ]
}
