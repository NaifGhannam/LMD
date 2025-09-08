//
//  MainTabView.swift
//  LMD
//
//  Created by Tahani on 24/02/1447 AH.
//

import SwiftUI
struct MainTabView: View {
    @EnvironmentObject var loginViewModel: LoginViewModel
    @EnvironmentObject var languageManager: LanguageManager
    
    var body: some View {
        TabView {
            GeneralPoolView()
                .environmentObject(GeneralPoolViewModel())
                .tabItem {
                    Label(NSLocalizedString("tab_home", comment: ""), systemImage: "shippingbox.fill")
                }
            
            MyOrdersView()
                .tabItem {
                    Label(NSLocalizedString("tab_orders", comment: ""), systemImage: "text.page.badge.magnifyingglass")
                }
            
            OrderHistoryView()
                .tabItem {
                    Label(NSLocalizedString("tab_history", comment: ""), systemImage: "shippingbox.fill")
                }
            
            DeliveryLogView()
                .tabItem {
                    Label(NSLocalizedString("tab_logs", comment: ""), systemImage: "car.fill")
                }
            
            ProfileView()
                .tabItem {
                    Label(NSLocalizedString("tab_profile", comment: ""), systemImage: "person.crop.circle")
                }
        }
        .accentColor(Color("PrimaryRed"))
        .id(languageManager.currentLanguage)
    }
}
