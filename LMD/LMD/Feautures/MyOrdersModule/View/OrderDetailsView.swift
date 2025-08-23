//
//  OrderDetailsView.swift
//  LMD
//
//  Created by Tahani on 29/02/1447 AH.
//

import SwiftUI
import MapKit

struct OrderDetailsView: View {
    
    @EnvironmentObject private var viewModel: GeneralPoolViewModel
    
    var body: some View {
        
       VStack(spacing: 0) {
            
           HStack {
               
               Text("My Orders")
                   .font(.system(size: 25, weight: .semibold))
                   .foregroundColor(Color.white)
               
               Spacer()
               
           }
           .padding([.horizontal, .bottom], 20)
           .frame(maxWidth: .infinity)
           
           Group {
               if #available(iOS 17, *) {
                   Map(position: $viewModel.cameraPosition) {
                       ForEach(viewModel.locations) { location in
                           Annotation("", coordinate: location.coordinates) {
                               LocationMapAnnotationView(
                                   location: location,
                                   isSelected: viewModel.mapLocation == location
                               ) {
                                   viewModel.showNextLocation(location: location)
                               }
                           }
                       }
                   }
               } else {
                   Map(coordinateRegion: $viewModel.region,
                       annotationItems: viewModel.locations
                   ) { location in
                       MapAnnotation(coordinate: location.coordinates) {
                           LocationMapAnnotationView(
                               location: location,
                               isSelected: viewModel.mapLocation == location
                           ) {
                               viewModel.showNextLocation(location: location)
                           }
                       }
                   }
               }
           }
           
           DetailsCard()
               .padding(12)
               .padding(.bottom, 20)
        }
       .background(Color("PrimaryRed"))
       .ignoresSafeArea(edges: .bottom)
    }
}

#Preview {
    OrderDetailsView()
        .environmentObject(GeneralPoolViewModel())
}
