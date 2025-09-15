//
//  PrimaryActionButton.swift
//  LMD
//
//  Created by Tahani on 05/03/1447 AH.
//

import SwiftUI

struct PrimaryActionButton: View {
    
    let title: String
    let action: () -> Void
    
    var body: some View {
        
        Button(title, action: action)
            .font(.system(size: 16, weight: .semibold))
            .frame(maxWidth: .infinity)
            .padding(10)
            .background(Color("PrimaryRed"))
            .foregroundColor(.white)
            .cornerRadius(10)
    }
}
