//
//  CustomButton.swift
//  LMD
//
//  Created by Tahani on 25/02/1447 AH.
//

import SwiftUI

struct CustomButton: View {
    
    var showIcon: Bool = false
    var title: String = "Title"
    var action: (() -> ())?
    
    var body: some View {
        
        Button(action: { action?() }) {
            
            HStack {
                
                if showIcon {
                   
                    Image(systemName: "phone.fill")
                        .resizable()
                        .frame(width: 16, height: 16)
                        .padding(.horizontal, 8)
                }
                
                Spacer()
                
                Text(title)
                
                Spacer()
                
                if showIcon {
                   
                    Spacer()
                        .frame(width: 16, height: 16)
                        .padding(.horizontal, 8)
                }
            }
            .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity)
        .padding(8)
        .background(Color("PrimaryRed"))
        .cornerRadius(10)
    }
}

#Preview {
    CustomButton()
        .padding()
}
