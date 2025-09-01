//
//  MainTabView.swift
//  LMD
//
//  Created by Tahani on 24/02/1447 AH.
//

import SwiftUI

struct MainTabView: View {
    
    @Binding var selectedTab: String
    
    var body: some View {
        HStack {
            
            CustomTabView(image: "box", text: "Home", selectedTab: $selectedTab)
            
            CustomTabView(image: "delivery-box", text: "Orders", selectedTab: $selectedTab)
            
            CustomTabView(image: "report", text: "History", selectedTab: $selectedTab)
            
            CustomTabView(image: "box", text: "Logs", selectedTab: $selectedTab)
            
            CustomTabView(image: "user", text: "Profile", selectedTab: $selectedTab)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(25)
        .padding(.horizontal)
        .shadow(radius: 5)
    }
}

