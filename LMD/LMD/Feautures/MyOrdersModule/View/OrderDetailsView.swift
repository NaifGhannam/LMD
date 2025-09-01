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
                       ForEach(viewModel.orders, id: \.orderID) { location in
                           Annotation("", coordinate: location.coordinate2D) {
                               LocationMapAnnotationView(
                                   location: location,
                                   isSelected: viewModel.mapOrder?.orderID == location.orderID
                               ) {
                                   viewModel.showNextLocation(order: location)
                               }
                           }
                       }
                   }
               } else {
                   Map(coordinateRegion: $viewModel.region,
                       annotationItems: viewModel.orders
                   ) { location in
                       MapAnnotation(coordinate: location.coordinate2D) {
                           LocationMapAnnotationView(
                               location: location,
                               isSelected: viewModel.mapOrder?.orderID == location.orderID
                           ) {
                               viewModel.showNextLocation(order: location)
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
       .task {
           await viewModel.fetchOrders()
       }
    }
}
