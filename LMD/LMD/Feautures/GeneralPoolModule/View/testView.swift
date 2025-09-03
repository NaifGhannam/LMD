//
//  testView.swift
//  LMD
//
//  Created by Naif on 09/03/1447 AH.
//



import SwiftUI

struct testView: View {
    @ObservedObject var viewModel = GeneralPoolViewModel()
    @StateObject var orderViewModel = MyOrdersViewModel()
    private let serviceName = Bundle.main.bundleIdentifier ?? "com.lmd.app"
    
    var body: some View {
        VStack{
            ScrollView (.horizontal){
                HStack (spacing : 0){
                    ForEach(viewModel.filteredOrders()){ order  in
                        Button (action: {viewModel.showNextLocation(order: order)}) {
                            Orders_On_General_Pool_Card(name: order.customerName ,
                                                        orderID: order.orderNumber ,
                                                        CreatedAt: order.orderDate ,
                                                        RoadDistance: order.distanceKm,
                                                        action: { Task {
                                guard let assignedAgentId = KeychainHelper.shared.read(service: serviceName, account: "userId") else { return }
                                await orderViewModel.updateOrderStatues(orderId: order.orderID, statusId: OrderStatusEnum.added.rawValue, assignedAgentId: assignedAgentId)
                                
                            }}
                            )
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

//#Preview {
//    testView()
//}
