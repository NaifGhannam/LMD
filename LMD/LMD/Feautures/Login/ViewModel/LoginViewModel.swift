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
    @Published var loggedInUser: LoginData?

    private let loginService: LoginServiceProtocol

    init(service: LoginServiceProtocol = LoginService()) {
        self.loginService = service
        loadUserFromDefaults()
    }
    
    func login() async {
        isLoading = true
        errorMessage = nil
        do {
            let request = LoginRequest(email: email, password: password)
            let response = try await loginService.login(request: request)
            
            guard let data = response.data else {
                throw NetworkError.unknown
            }
            
            self.loggedInUser = data
            
            // تخزين بيانات المستخدم في UserDefaults
            if let encodedData = try? JSONEncoder().encode(data) {
                UserDefaults.standard.set(encodedData, forKey: "loggedInUser")
            }
            
        } catch {
            errorMessage = "Login failed: \(error.localizedDescription)"
        }
        isLoading = false
    }
    
    private func loadUserFromDefaults() {
        if let data = UserDefaults.standard.data(forKey: "loggedInUser"),
           let user = try? JSONDecoder().decode(LoginData.self, from: data) {
            self.loggedInUser = user
        }
    }
}
