//
//  MyOrdersView.swift
//  LMD
//
//  Created by Tahani on 25/02/1447 AH.
//

import SwiftUI

struct MyOrdersView: View {
    
    @StateObject var viewModel: MyOrdersViewModel
    
    var body: some View {
        
        NavigationStack {
            
            VStack(spacing: 0) {
                
                MyOrdersViewHeader(viewModel: viewModel)
                
                ScrollView {
                    LazyVStack(spacing: 20) {
                        ForEach(viewModel.filterData(), id: \.orderID) { order in
                            DetailsCard(order: order, viewModel: viewModel)
                                .padding(.horizontal, 25)
                                .onAppear {
                                    Task { await viewModel.loadMoreOrdersIfNeeded(currentOrder: order) }
                                }
                        }
                        if viewModel.isLoading {
                            ProgressView("Loading more...").padding()
                        }
                    }
                    .padding(.top, 15)

                    Spacer().frame(height: UIScreen.main.bounds.height * 0.12)
                }

            }
            .task {
                await viewModel.fetchMyOrders()
                
                for item in viewModel.filterData()
                {
                    print("\(item.customerName) - \(item.assignedAgentID)")
                }
                print("----------------------------")
                print(viewModel.filterData().count)
            }
            .ignoresSafeArea(edges: .bottom)
        }
    }
}
