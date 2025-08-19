//
//  MyOrdersViewHeader.swift
//  LMD
//
//  Created by Tahani on 25/02/1447 AH.
//

import SwiftUI

struct MyOrdersViewHeader: View {
    
    @ObservedObject var viewModel: MyOrdersViewModel
    
    var body: some View {
        
        VStack {
            HStack {
                
                Text("My Orders")
                    .font(.system(size: 25, weight: .semibold))
                    .foregroundColor(Color.white)
                
                Spacer()
                
            }
            .padding([.horizontal, .bottom], 20)
            
            HStack {
                
                Spacer()
                
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundColor(.gray)
                    .padding(10)
                
                TextField("Search By Order Number", text: $viewModel.searchText)
                .frame(height: 50)
            }
            .background(.white)
            .cornerRadius(6)
            .padding([.horizontal, .bottom], 20)
        }
        .frame(maxWidth: .infinity)
        .background(Color("PrimaryRed"))
    }
}
