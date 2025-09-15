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
    private let container = AppContainer()
    
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
           .background(Color("PrimaryRed"))
           
           Group {
               if #available(iOS 17, *) {
                   Map(
                       position: .constant(
                           .region(
                               MKCoordinateRegion(
                                   center: order.coordinate2D,
                                   span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
                               )
                           )
                       )
                   ) {
                       Annotation("", coordinate: order.coordinate2D) {
                           Image("MapMarker")
                               .resizable()
                               .scaledToFit()
                               .frame(width: 35, height: 35)
                               .shadow(radius: 10)
                       }
                   }
               } else {
                   Map(
                       coordinateRegion: .constant(
                           MKCoordinateRegion(
                               center: order.coordinate2D,
                               span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
                           )
                       ),
                       annotationItems: [order]
                   ) { location in
                       MapAnnotation(coordinate: location.coordinate2D) {
                           Image("MapMarker")
                               .resizable()
                               .scaledToFit()
                               .frame(width: 35, height: 35)
                               .shadow(radius: 10)
                       }
                   }
               }
           }
           
           VStack {
               DetailsCard(order: order, viewModel: container.makeMyOrdersVM(), isShowDetailsBtn: false)
                   .padding(12)
           }
           .background(Color("PrimaryRed"))
           
           Spacer()
        }
       .navigationBarHidden(true)
       .navigationBarBackButtonHidden(true)
       .task {
           await viewModel.fetchOrders()
       }
    }
}
