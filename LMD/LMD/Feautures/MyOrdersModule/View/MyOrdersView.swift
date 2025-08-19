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
        
        VStack {
            
            MyOrdersViewHeader(viewModel: viewModel)
                .padding(.bottom, 20)
            
            VStack(spacing: 20) {
                
                ForEach(viewModel.filterData()) { order in
                   
                    DetailsCard(order: order)
                }
            }

            Spacer()
        }
        .background(.gray.opacity(0.15))
    }
}

#Preview {
    MyOrdersView()
}
