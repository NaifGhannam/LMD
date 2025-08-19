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
                
                Spacer()
                
                ZStack {
                    if selectedTab == "Home" {
                        
                        Text("Page 1")
                        
                    } else if selectedTab == "Orders" {
                        
                        Text("Page 2")
                        
                    } else if selectedTab == "History" {
                        
                        Text("Page 3")
                        
                    } else if selectedTab == "Logs" {
                        
                        Text("Page 4")
                        
                    } else {
                        
                        Text("Page 5")
                    }
                }
                
                Spacer()
                
                MainTabView(selectedTab: $selectedTab)
            }
            .padding(.vertical)
            .ignoresSafeArea()
        }
    }
}

#Preview {
    ContentView()
}
