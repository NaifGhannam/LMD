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
    let order: Order
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
       VStack(spacing: 0) {
            
           HStack {
               
               Button(action: { dismiss() }) {
                   
                   Image(systemName: "chevron.backward")
               }
               .padding(.trailing, 20)
               
               Text("My Orders")
                   .font(.system(size: 25, weight: .semibold))
               
               Spacer()
               
           }
           .foregroundColor(Color.white)
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
           
           DetailsCard(order: order, viewModel: MyOrdersViewModel())
               .padding(12)
               .padding(.bottom, 20)
        }
       .background(Color("PrimaryRed"))
       .ignoresSafeArea(edges: .bottom)
       .navigationBarHidden(true)
       .navigationBarBackButtonHidden(true)
    }
}
