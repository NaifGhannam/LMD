//
//  LMDApp.swift
//  LMD
//
//  Created by Naif on 24/02/1447 AH.
//
import SwiftUI
@main
struct LMDApp: App {
    
    @StateObject private var loginViewModel = LoginViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                if loginViewModel.loggedInUser != nil {
                    MainTabView()
                        .environmentObject(loginViewModel)
                        .navigationBarHidden(true) 
                } else {
                    LoginView()
                        .environmentObject(loginViewModel)
                        .navigationBarHidden(true)
                }
            }
        }
    }
}
