//
//  LoginViewModel.swift
//  LMD
//  Created by Naif on 24/02/1447 AH.
//

import SwiftUI

@MainActor
class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var loggedInUser: User?

    private let loginService: LoginServiceProtocol
    private let logoutService: LogoutServiceProtocol


    // Storage keys for UserDefaults and Keychain accounts
    private enum StorageKey {
        static let loggedInUser = "loggedInUser"
        static let accessToken = "accessToken"
        static let refreshToken = "refreshToken"
        static let userId = "userId"
    }

    init(service: LoginServiceProtocol = LoginService(),
         logoutService: LogoutServiceProtocol = LogoutService()
        ) {
        self.loginService = service
        self.logoutService = logoutService
        loadUserFromDefaults()
    }

    /// Perform login, save user in UserDefaults and tokens in Keychain
    func login() async {
        isLoading = true
        defer { isLoading = false } // ensure loading flag is cleared
        errorMessage = nil
        guard validateInputs() else {
            isLoading = false
            return
        }

        do {
            let request = LoginRequest(email: email, password: password)
            let response = try await loginService.login(request: request)

            guard let data = response.data else {
                throw NetworkError.unknown
            }

            // Save user info to UserDefaults
            self.loggedInUser = data.user
            if let encodedUser = try? JSONEncoder().encode(data.user) {
                UserDefaults.standard.set(encodedUser, forKey: StorageKey.loggedInUser)
            }

            // Save tokens to Keychain (use bundle id as service)
            let service = Bundle.main.bundleIdentifier ?? "com.lmd.app"
            KeychainHelper.shared.save(data.accessToken,
                                       service: service,
                                       account: StorageKey.accessToken)

            KeychainHelper.shared.save(data.refreshToken,
                                       service: service,
                                       account: StorageKey.refreshToken)
            
            // Save userId to Keychain
            KeychainHelper.shared.save(data.user.id,
                                       service: service,
                                       account: StorageKey.userId)


            // Clear password from memory
            password = ""

        } catch {
            errorMessage = "Login failed: \(error.localizedDescription)"
        }
    }

    /// Load user from UserDefaults if exists
    private func loadUserFromDefaults() {
        if let stored = UserDefaults.standard.data(forKey: StorageKey.loggedInUser),
           let user = try? JSONDecoder().decode(User.self, from: stored) {
            self.loggedInUser = user
        }
    }

    func logout() {
          Task {
              do {
                  let success = try await logoutService.logout()
                  if success {
                      clearLocalData() // clear tokens + user data
                  } else {
                      errorMessage = "Logout failed on server"
                  }
              } catch {
                  errorMessage = "Logout failed: \(error.localizedDescription)"
              }
          }
        print("successfully logged out")
      }

      // 🔹 Extracted local data cleanup into a private helper
      private func clearLocalData() {
          loggedInUser = nil
          UserDefaults.standard.removeObject(forKey: StorageKey.loggedInUser)

          let service = Bundle.main.bundleIdentifier ?? "com.lmd.app"
          KeychainHelper.shared.delete(service: service, account: StorageKey.accessToken)
          KeychainHelper.shared.delete(service: service, account: StorageKey.refreshToken)
          KeychainHelper.shared.delete(service: service, account: StorageKey.userId)
      }

    
    func validateInputs() -> Bool {
        if email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            errorMessage = "Email is required."
            return false
        }
        
        if !isValidEmail(email) {
            errorMessage = "Invalid email format."
            return false
        }

        if password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            errorMessage = "Password is required."
            return false
        }

        return true
    }

    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }

}
