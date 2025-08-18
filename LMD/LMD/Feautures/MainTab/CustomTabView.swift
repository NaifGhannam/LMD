//
//  CustomTabView.swift
//  LMD
//
//  Created by Tahani on 24/02/1447 AH.
//

import SwiftUI

struct CustomTabView: View {
    
    let image: String
    let text: String
    @Binding var selectedTab: String
    
    var body: some View {
        GeometryReader { geometry in
            Button(action: {
                withAnimation(.linear(duration: 0.3)) {
                    self.selectedTab = self.text
                }
            }) {
                VStack(spacing: 0) {
                    Image("\(image)\(selectedTab == text ? "-red" : "")")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .offset(y: selectedTab == text ? -5 : 0)
                        .scaleEffect(selectedTab == text ? 1.2 : 1)
                    
                    Text(text)
                        .foregroundColor(selectedTab == text ? Color("PrimaryRed") : .gray)
                        .opacity(selectedTab == text ? 1 : 0)
                        
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(height: 50)
    }
}
