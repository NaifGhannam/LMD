//
//  OrderHistoryView.swift
//  LMD
//
//  Created by Naif on 10/03/1447 AH.
//

import SwiftUI

struct OrderHistoryView: View {
    @StateObject var vm = MyOrdersViewModel()    

    var body: some View {
        VStack {
            Text("Order History")
                .font(.largeTitle)
                .padding(5)
                .frame(maxWidth: .infinity)
                .background(Color.red)
                .foregroundColor(.white)
            ScrollView {
                ForEach(filteredOrders, id: \.orderID) { order in
                    OrderHistoryCard(
                        price: 343,
                        Number: order.orderNumber,
                        name: order.customerName,
                        time: order.orderDate
                    )
                }
            }
        }
        .task {
            await vm.fetchMyOrders()
        }
    }
    
    private var filteredOrders: [Order] {
        vm.orders.filter { [3, 7, 8].contains($0.statusID) }
    }
}
#Preview {
    OrderHistoryView()
}

#Preview {
    OrderHistoryView()
}
