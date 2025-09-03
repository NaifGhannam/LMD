//
//  GeneralPoolViewModel.swift
//  LMD
//
//  Created by Tahani on 25/02/1447 AH.
//

import SwiftUI
import MapKit
import CoreLocation

@MainActor
class GeneralPoolViewModel: NSObject, ObservableObject {
    @Published var searchText = ""
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var orders: [Order] = []
    @Published var mapOrder: Order? { didSet { if let o = mapOrder { focusOn(order: o) } } }
    @Published var cameraPosition: MapCameraPosition = .automatic
    @Published var region: MKCoordinateRegion = .init()
    
    private let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    private let svc: GeneralPoolServiceProtocol
    private let lm = CLLocationManager()
    
    private var userCoord: CLLocationCoordinate2D?
    private var lastZoomKm: Double = 100
    
    init(generalPoolService: GeneralPoolServiceProtocol = GeneralPoolService()) {
        self.svc = generalPoolService
        super.init()
    }
    
    func fetchOrders() async {
        
        isLoading = true
        
        defer { isLoading = false }
        
        do {
            orders = try await svc.getGeneralPool().data.initialOrders
        }
        catch {
            errorMessage = error.localizedDescription
        }
    }
    
    private func focusOn(order: Order) {
        let r = MKCoordinateRegion(center: order.coordinate2D, span: span)
        region = r
        cameraPosition = .region(r)
    }
    
    func showNextLocation(order: Order) { withAnimation(.easeInOut) { mapOrder = order } }
    
    func filteredOrders() -> [Order] {
        let t = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !t.isEmpty else { return orders }
        return orders.filter { $0.customerName.localizedCaseInsensitiveContains(t) || $0.orderNumber.localizedCaseInsensitiveContains(t) }
    }
    
    func start() async {
        lm.delegate = self
        handleAuth(lm.authorizationStatus)
    }
    
    private func handleAuth(_ s: CLAuthorizationStatus) {
        switch s {
        case .notDetermined:
            lm.requestWhenInUseAuthorization()
        case .authorizedAlways, .authorizedWhenInUse:
            lm.startUpdatingLocation()
            if let c = lm.location?.coordinate { userCoord = c }
            if let c = userCoord { applyRegion(center: c, km: lastZoomKm) }
        case .restricted, .denied:
            break
        @unknown default:
            break
        }
    }
    
    func updateZoom(distanceKm: Double) {
        lastZoomKm = max(0, min(100, distanceKm))
        guard let c = userCoord else { return }
        applyRegion(center: c, km: lastZoomKm)
    }
    
    private func span(for km: Double, at lat: CLLocationDegrees) -> MKCoordinateSpan {
        let k = max(km, 0.2)
        let latDelta = k / 111.0
        let lonDelta = k / (111.0 * max(cos(lat * .pi / 180), 0.0001))
        return .init(latitudeDelta: latDelta, longitudeDelta: lonDelta)
    }
    
    private func applyRegion(center: CLLocationCoordinate2D, km: Double) {
        let r = MKCoordinateRegion(center: center, span: span(for: km, at: center.latitude))
        cameraPosition = .region(r)
        region = r
    }
}

// MARK: - CLLocationManagerDelegate
extension GeneralPoolViewModel: CLLocationManagerDelegate {
    
    nonisolated func locationManagerDidChangeAuthorization(_ m: CLLocationManager) {
        Task { @MainActor in self.handleAuth(m.authorizationStatus) }
    }
    
    nonisolated func locationManager(_ m: CLLocationManager, didUpdateLocations locs: [CLLocation]) {
        guard let c = locs.last?.coordinate else { return }
        Task { @MainActor in
            self.userCoord = c
            if self.mapOrder == nil { self.applyRegion(center: c, km: self.lastZoomKm) }
        }
    }
    
    nonisolated func locationManager(_ m: CLLocationManager, didFailWithError error: Error) { }
}
