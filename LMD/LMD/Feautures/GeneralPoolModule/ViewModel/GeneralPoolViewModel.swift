//
//  GeneralPoolViewModel.swift
//  LMD
//
//  Created by Tahani on 25/02/1447 AH.
//

import SwiftUI
import MapKit

class GeneralPoolViewModel: ObservableObject {
    
    @Published var searchText = ""
    @Published var isLoading = false
    @Published var orders: [Order] = []
    @Published var errorMessage: String?
    @Published var locations: [Location]
    @Published var mapLocation: Location {
        didSet { updateCamera(to: mapLocation) }
    }
    
    @Published var cameraPosition: MapCameraPosition
    @Published var region: MKCoordinateRegion = .init()
    
    private let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    
    
    private let generalPoolService : GeneralPoolServiceProtocol
    
    init(generalPoolService: GeneralPoolServiceProtocol = GeneralPoolService()) {
        let locations = LocationsDataService.locations
        self.locations = locations
        let first = locations.first!
        self.mapLocation = first
        
        let initialRegion = MKCoordinateRegion(center: first.coordinates, span: span)
        self.region = initialRegion
        self.cameraPosition = .region(initialRegion)
        self.generalPoolService = generalPoolService
    }
    
    private func updateCamera(to location: Location) {
        withAnimation {
            let newRegion = MKCoordinateRegion(center: location.coordinates, span: span)
            region = newRegion
            cameraPosition = .region(newRegion)       
        }
    }
    
    func showNextLocation(location: Location) {
        withAnimation(.easeInOut) {
            mapLocation = location
        }
    }
    
    func filteredLocations() -> [Location] {
        
        let text = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !text.isEmpty else {
            return locations
        }
        
        return locations.filter {
            $0.customerName.localizedCaseInsensitiveContains(text)
            || $0.orderNo.localizedCaseInsensitiveContains(text)
        }
    }
    
    func loadOrders() async {
        
        self.isLoading = true
        self.errorMessage = nil
        
        do {
            
            let result = try await generalPoolService.getGeneralPool()
            self.orders = result.data.initialOrders
            print("-----------------------------------------------")
            
        } catch {
            self.errorMessage = error.localizedDescription
        }
        
        self.isLoading = false
        
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
