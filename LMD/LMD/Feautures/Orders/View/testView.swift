//
//  testView.swift
//  LMD
//
//  Created by Naif on 25/02/1447 AH.
//

import SwiftUI

struct testView: View {
    @StateObject var viewModel = MyOrdersViewModel()
    var body: some View {
        VStack{
    
            ScrollView (.horizontal){
                HStack (spacing : 0){
                    ForEach(viewModel.orders,id : \.orderID){order  in
                        Orders_On_General_Pool_Card(name: order.customerName , orderID: order.orderID , CreatedAt: order.orderDate , numberOfOrders: 22 , RoadDistance: order.distanceKm )
                        
                    }
                }
            }
        }
        .task {
            await viewModel.fetchMyOrders()
        }
    }
}

//#Preview {
//    testView()
//}
