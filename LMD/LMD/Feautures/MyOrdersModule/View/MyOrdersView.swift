//
//  MyOrdersView.swift
//  LMD
//
//  Created by Tahani on 25/02/1447 AH.
//

import SwiftUI

struct MyOrdersView: View {
    
    @StateObject var viewModel = MyOrdersViewModel()
    
    var body: some View {
        
        NavigationStack {
          
            VStack(spacing: 0) {
                
                MyOrdersViewHeader(viewModel: viewModel)
                    
                ScrollView {
                    VStack(spacing: 20) {
                        
                        ForEach(viewModel.filterData(), id: \.orderID) { order in
                           
                            DetailsCard(order: order, viewModel: viewModel)
                                .padding(.horizontal, 25)
                        }
                    }
                    .padding(.top, 15)
                }
            }
            .task {
                await viewModel.fetchMyOrders()
            }
            .ignoresSafeArea(edges: .bottom)
        }
    }
}

#Preview {
    MyOrdersView()
        .background(.gray.opacity(0.15))
}
