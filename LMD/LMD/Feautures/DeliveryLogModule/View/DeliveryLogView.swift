//
//  DeliveryLogView.swift
//  LMD
//
//  Created by Tahani on 02/03/1447 AH.
//
import SwiftUI

struct DeliveryLogView: View {
    @ObservedObject var vm = MyOrdersViewModel()
    
    var body: some View {
        VStack {
            HStack {
               Text("Delivery Log")
                    .font(.system(size: 20, weight: .bold))
                Spacer()
                
            }
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color("PrimaryRed"))
            
            VStack {
                HStack {
                    Text("SLA")
                    Text("Order details")
                        .font(.system(size: 18))
                        .padding(.horizontal, 14)
                    Spacer()
                    Text("Delivery time")
                }
                .foregroundColor(.gray)
                
                ScrollView {
                    VStack(spacing: 10) {
                        ForEach(filteredOrders, id: \.orderID) { order in
                            DeliveryLogCard(order: order)
                        }
                    }
                }
            }
            .padding(20)
            
            Spacer()
            
        }
        .task {
            await vm.fetchMyOrders()
        }
       
    }
    private var filteredOrders: [Order] {
         vm.orders.filter{[3,7,8].contains($0.statusID)}
    }
}
extension Order {
    var relativeTime: String {
        // compute "30 mins ago" etc.
        return "30 mins ago" // placeholder
    }
}
