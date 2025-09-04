//
//  MainTabView.swift
//  LMD
//
//  Created by Tahani on 24/02/1447 AH.
//

import SwiftUI
struct MainTabView: View {
    @EnvironmentObject var loginViewModel: LoginViewModel
    
    var body: some View {
        TabView {
            GeneralPoolView()
                .environmentObject(GeneralPoolViewModel())
                .tabItem { Label("Home", systemImage: "shippingbox.fill") }
            
            MyOrdersView()
                .tabItem { Label("Orders", systemImage: "text.page.badge.magnifyingglass") }
            
            OrderHistoryView()
                .tabItem { Label("History", systemImage: "shippingbox.fill") }
            
            DeliveryLogView()
                .tabItem { Label("Logs", systemImage: "car.fill") }
            
            ProfileView()
                .tabItem { Label("Profile", systemImage: "person.crop.circle") }
        }
        .accentColor(Color("PrimaryRed"))
        
    }
}
