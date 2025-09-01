//
//  testView.swift
//  LMD
//
//  Created by Naif on 09/03/1447 AH.
//



import SwiftUI

struct testView: View {
    @ObservedObject var viewModel = GeneralPoolViewModel()
    var body: some View {
        VStack{
            ScrollView (.horizontal){
                HStack (spacing : 0){
                    ForEach(viewModel.filteredOrders()){ order  in
                        Button (action: {viewModel.showNextLocation(order: order)}) {
                            Orders_On_General_Pool_Card(name: order.customerName ,
                                orderID: order.orderNumber ,
                                CreatedAt: order.orderDate ,
                                RoadDistance: order.distanceKm )
                            .foregroundColor(.black)
                        }
                        
                    }
                }
            }
        }
        .task {
            await viewModel.fetchOrders()
        }
    }
}

#Preview {
    testView()
}
