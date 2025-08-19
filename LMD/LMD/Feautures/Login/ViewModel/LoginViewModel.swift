//
//  LoginViewModel.swift
//  LMD
//
//  Created by Naif on 24/02/1447 AH.
//

import SwiftUI

@MainActor
class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var isLoggedIn = false
    
    func login() async {
        isLoading = true
        errorMessage = nil
        
        do {
            let response = try await LoginService().login(email: email, password: password)
            
            KeychainHelper.shared.save(Data(response.tokens.access_token.utf8), service: "auth", account: "access_token")
            KeychainHelper.shared.save(Data(response.tokens.refresh_token.utf8), service: "auth", account: "refresh_token")
            
            isLoggedIn = response.success
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    func logout() {
        KeychainHelper.shared.delete(service: "auth", account: "access_token")
        KeychainHelper.shared.delete(service: "auth", account: "refresh_token")
        isLoggedIn = false
    }
    
    func getAccessToken() -> String? {
        if let data = KeychainHelper.shared.read(service: "auth", account: "access_token") {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
}
