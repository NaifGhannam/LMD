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
    @StateObject private var languageManager = LanguageManager() 
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                if loginViewModel.loggedInUser != nil {
                    MainTabView()
                        .environmentObject(loginViewModel)
                        .environmentObject(languageManager)
                        .navigationBarHidden(true)
                } else {
                    LoginView()
                        .environmentObject(loginViewModel)
                        .environmentObject(languageManager)
                      //  .navigationBarHidden(true)
                }
            }
            .environment(\.layoutDirection, languageManager.currentLanguage == .arabic ? .rightToLeft : .leftToRight)

        }
    }
}
