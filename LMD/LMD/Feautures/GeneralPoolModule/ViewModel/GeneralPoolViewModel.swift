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
    @Published var errorMessage: String?
    @Published var orders: [Order] = []
    @Published var mapOrder: Order? {
        didSet {
            if let order = mapOrder {
                updateCamera(to: order)
            }
        }
    }
    
    @Published var cameraPosition: MapCameraPosition
    @Published var region: MKCoordinateRegion = .init()
    
    private let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    private let generalPoolService : GeneralPoolServiceProtocol
    
    init(generalPoolService: GeneralPoolServiceProtocol = GeneralPoolService()) {
        self.generalPoolService = generalPoolService
        self.cameraPosition = .automatic
    }
    
    func fetchOrders() async {
        
        self.isLoading = true
        self.errorMessage = nil
        
        do {
            
            let result = try await generalPoolService.getGeneralPool()
            self.orders = result.data.initialOrders
            for item in result.data.initialOrders {
                print(item.coordinate2D.latitude)
                print(item.coordinate2D.longitude)
            }
            
        } catch {
            self.errorMessage = error.localizedDescription
        }
        
        self.isLoading = false
    }
    
    private func updateCamera(to order: Order) {
        withAnimation {
            let newRegion = MKCoordinateRegion(center: order.coordinate2D, span: span)
            region = newRegion
            cameraPosition = .region(newRegion)       
        }
    }
    
    func showNextLocation(order: Order) {
        withAnimation(.easeInOut) {
            mapOrder = order
        }
    }
    
    func filteredLocations() -> [Order] {
        
        let text = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !text.isEmpty else {
            return orders
        }
        
        return orders.filter {
            $0.customerName.localizedCaseInsensitiveContains(text)
            || $0.orderNumber.localizedCaseInsensitiveContains(text)
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
