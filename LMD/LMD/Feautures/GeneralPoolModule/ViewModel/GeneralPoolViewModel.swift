//
//  GeneralPoolViewModel.swift
//  LMD
//
//  Created by Tahani on 25/02/1447 AH.
//

import SwiftUI
import MapKit

@MainActor
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
    
    private let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
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
    
    func filteredOrders() -> [Order] {
        
        let text = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !text.isEmpty else {
            return orders
        }
        
        return orders.filter {
            $0.customerName.localizedCaseInsensitiveContains(text)
            || $0.orderNumber.localizedCaseInsensitiveContains(text)
        }
    }
}
