//
//  LMDApp.swift
//  LMD
//
//  Created by Naif on 24/02/1447 AH.
//

import SwiftUI

@main
struct LMDApp: App {
    
    @StateObject private var viewModel = GeneralPoolViewModel()
    
    var body: some Scene {
        WindowGroup {
            GeneralPoolView()
                .environmentObject(viewModel)
        }
    }
}
