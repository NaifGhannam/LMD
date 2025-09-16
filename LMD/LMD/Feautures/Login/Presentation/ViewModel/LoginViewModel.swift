//
//  LoginViewModel.swift
//  LMD
//
//  Created by Naif on 24/03/1447 AH.
//

import Foundation


@MainActor
final class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var loggedInUser: User?

    private let loginUseCase: LoginUseCase
    private let logoutUseCase: LogoutUseCase
    private let localStorage: UserLocalStorage

    init(repository: AuthRepository = AuthRepositoryImpl()) {
        self.loginUseCase = LoginUseCase(repository: repository)
        self.logoutUseCase = LogoutUseCase(repository: repository)
        self.localStorage = UserLocalStorage()
        self.loggedInUser = localStorage.loadUser()
    }

    func login() async {
        isLoading = true
        defer { isLoading = false }
        errorMessage = nil

        guard validateInputs() else { return }

        do {
            let session = try await loginUseCase.execute(email: email, password: password)
            self.loggedInUser = session.user

            password = ""
        } catch {
            errorMessage = "Login failed: \(error.localizedDescription)"
        }
    }

    func logout() async {
        do {
            let success = try await logoutUseCase.execute()
            if success { loggedInUser = nil }
        } catch {
            errorMessage = "Logout failed: \(error.localizedDescription)"
        }
    }

    private func validateInputs() -> Bool {
        if email.trimmingCharacters(in: .whitespaces).isEmpty {
            errorMessage = "Email is required."
            return false
        }
        let regex = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        if !NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: email) {
            errorMessage = "Invalid email format."
            return false
        }
        if password.isEmpty {
            errorMessage = "Password is required."
            return false
        }
        return true
    }
}
