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
            
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                TextField("Search by order number", text: $vm.searchText)
                    .textFieldStyle(PlainTextFieldStyle())
                if !vm.searchText.isEmpty {
                    Button(action: { vm.searchText = "" }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding(8)
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .padding(.horizontal, 16)
            
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
        var base = vm.orders.filter { [3, 7, 8].contains($0.statusID) }
        
        let query = vm.searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        if !query.isEmpty {
            base = base.filter {
                $0.orderNumber.localizedCaseInsensitiveContains(query) 
            }
        }
        
        return base
    }
}

extension Order {
    var relativeTime: String {
        return "30 mins ago"
    }
}
