//
//  PoolViewHeader.swift
//  LMD
//
//  Created by Tahani on 29/02/1447 AH.
//

import SwiftUI

struct PoolViewHeader: View {
    
    @EnvironmentObject private var viewModel: GeneralPoolViewModel
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 12) {
            Text("My Pool")
                .font(.system(size: 25, weight: .semibold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .center)
            
            HStack {
                
                HStack(spacing: 8) {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    
                    TextField("Search by order NO or customer name", text: $viewModel.searchText)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                        .foregroundColor(Color.black)
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 10)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                .overlay(
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .stroke(.white.opacity(0.25), lineWidth: 1)
                )
                
                Image(systemName: "chevron.down")
                    .bold()
                    .foregroundColor(.white)
            }
            
        }
        .padding(.horizontal)
        .padding(.top, 8)
        .padding(.bottom, 12)
        .background(Color("PrimaryRed"))
    }
}
