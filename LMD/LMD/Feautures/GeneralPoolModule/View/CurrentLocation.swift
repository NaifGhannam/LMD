//
//  CurrentLocation.swift
//  LMD
//
//  Created by Tahani on 10/03/1447 AH.
//

import SwiftUI
import MapKit

struct CurrentLocation: View {
    
    let cameraPosition: MapCameraPosition = .region(.init(center: .init(latitude: 37.3346, longitude: -122.0090), latitudinalMeters: 1300, longitudinalMeters: 1300))
    
    let locationManager = CLLocationManager()
    
    var body: some View {
        Map(initialPosition: cameraPosition) {
            
            Annotation("Apple Visitor Center", coordinate: .appleVisitorCenter, anchor: .bottom) {
                
                Image(systemName: "laptopcomputer")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundStyle(.white)
                    .frame(width: 20, height: 20)
                    .padding(7)
                    .background(.pink.gradient, in: .circle)
            }
           
            UserAnnotation()
        }
        .tint(.pink)
        .onAppear {
            locationManager.requestWhenInUseAuthorization()
        }
        .mapControls {
            MapUserLocationButton()
            MapCompass()
            MapPitchToggle()
            MapScaleView()
        }
    }
}

#Preview {
    CurrentLocation()
}

extension CLLocationCoordinate2D {
    static let appleHQ = CLLocationCoordinate2D(latitude: 37.3346, longitude: -122.0090)
    static let appleVisitorCenter = CLLocationCoordinate2D(latitude: 37.332753, longitude: -122.005372)
    static let panamaPark = CLLocationCoordinate2D(latitude: 37.347730, longitude: -122.018715)
}
