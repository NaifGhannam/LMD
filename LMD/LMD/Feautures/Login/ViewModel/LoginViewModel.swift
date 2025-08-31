//
//  LoginViewModel.swift
//  LMD
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

    // Storage keys for UserDefaults and Keychain accounts
    private enum StorageKey {
        static let loggedInUser = "loggedInUser"
        static let accessToken = "accessToken"
        static let refreshToken = "refreshToken"
    }

    init(service: LoginServiceProtocol = LoginService()) {
        self.loginService = service
        loadUserFromDefaults()
    }

    /// Perform login, save user in UserDefaults and tokens in Keychain
    func login() async {
        isLoading = true
        defer { isLoading = false } // ensure loading flag is cleared
        errorMessage = nil

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
            KeychainHelper.shared.save(Data(data.accessToken.utf8),
                                       service: service,
                                       account: StorageKey.accessToken)

            KeychainHelper.shared.save(Data(data.refreshToken.utf8),
                                       service: service,
                                       account: StorageKey.refreshToken)

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

    /// Logout: clear local user & remove tokens from Keychain
    func logout() {
        loggedInUser = nil
        UserDefaults.standard.removeObject(forKey: StorageKey.loggedInUser)

        let service = Bundle.main.bundleIdentifier ?? "com.lmd.app"
        KeychainHelper.shared.delete(service: service, account: StorageKey.accessToken)
        KeychainHelper.shared.delete(service: service, account: StorageKey.refreshToken)
    }

    /// Helper to read access token (useful for NetworkManager)
    func getAccessToken() -> String? {
        let service = Bundle.main.bundleIdentifier ?? "com.lmd.app"
        guard let data = KeychainHelper.shared.read(service: service, account: StorageKey.accessToken),
              let token = String(data: data, encoding: .utf8) else {
            return nil
        }
        return token
    }
}
