//
//  LoginViewModel.swift
//  LMD
//
//  Created by Naif on 24/02/1447 AH.
//

import SwiftUI

@MainActor
class LoginViewModel: ObservableObject {
    @Published var username = ""
    @Published var password = ""
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var isLoggedIn = false
    @Published var user: User?
    
    func login() async {
        isLoading = true
        errorMessage = nil
        
        do {
            let response = try await LoginService().login( username : username, password: password)
            if response.success {
                user = response.user
                isLoggedIn = true
            } else {
                errorMessage = response.message
            }
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
}

