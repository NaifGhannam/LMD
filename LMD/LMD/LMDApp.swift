//
//  LMDApp.swift
//  LMD
//
//  Created by Naif on 24/02/1447 AH.
//

import SwiftUI

@main
struct LMDApp: App {
    
    init() {
        Task { await AuthSession.shared.bootstrapFromKeychain() }
    }
    
    @StateObject private var viewModel = GeneralPoolViewModel()
    
    var body: some Scene {
        WindowGroup {
            MyOrdersView()
                .environmentObject(viewModel)
        }
    }
}
