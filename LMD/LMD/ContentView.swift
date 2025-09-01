//
//  ContentView.swift
//  LMD
//
//  Created by Naif on 24/02/1447 AH.
//

import SwiftUI

struct ContentView: View {
    
    @State var selectedTab: String = "Home"
    
    var body: some View {
        ZStack(alignment: .bottom) {
            
            VStack {
                
                ZStack {
                    if selectedTab == "Home" {
                        
                        GeneralPoolView()
                            .environmentObject(GeneralPoolViewModel())
                        
                    } else if selectedTab == "Orders" {
                        
                        MyOrdersView()
                        
                    } else if selectedTab == "History" {
                        
                        Text("Page 3")
                        
                    } else if selectedTab == "Logs" {
                        
                        testLogoutView()
                    } else {
                        
                        Text("Page 5")
                    }
                }
                
                Spacer()
                
                MainTabView(selectedTab: $selectedTab)
            }
            .padding(.bottom)
            .background(.clear)
            .ignoresSafeArea(edges: .bottom)
        }
    }
}

#Preview {
    ContentView()
}
