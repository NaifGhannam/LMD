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
                        
                        ForEach(viewModel.filterData(), id: \.id) { order in
                            
                            DetailsCard(order: order, viewModel: viewModel)
                                .padding(.horizontal, 25)
                            
                            if order.id == viewModel.filterData().last?.id,
                               viewModel.hasMore
                            {
                                HStack {
                                    Spacer()
                                    if viewModel.isLoading { ProgressView() }
                                    Spacer()
                                }
                                .onAppear {
                                    Task { await viewModel.fetchMyOrders() }
                                }
                            }
                        }
                    }
                    .padding(.top, 15)
                    
                    Spacer()
                        .frame(height: UIScreen.main.bounds.height * 0.12)
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
