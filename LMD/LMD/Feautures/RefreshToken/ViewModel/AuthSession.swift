//
//  AuthSession.swift
//  LMD
//
//  Created by Tahani on 09/03/1447 AH.
//

import Foundation

actor AuthSession {
    
    static let shared = AuthSession()

    private(set) var accessToken: String?
    private(set) var refreshToken: String?

    // Coalesce parallel refreshes
    private var inFlightRefresh: Task<String, Error>?

    // Keychain wiring
    private let kc = KeychainHelper.shared
    private let service = "com.yourbundle.auth"   // <- change to your bundle id or a stable string
    private let accessAccount  = "accessToken"
    private let refreshAccount = "refreshToken"

    // Call this once early in app lifecycle
    func bootstrapFromKeychain() {
        self.accessToken  = kc.readString(service: service, account: accessAccount)
        self.refreshToken = kc.readString(service: service, account: refreshAccount)
    }

    func setTokens(access: String, refresh: String) {
        self.accessToken  = access
        self.refreshToken = refresh
        kc.saveString(access,  service: service, account: accessAccount)
        kc.saveString(refresh, service: service, account: refreshAccount)
    }

    func updateAccessToken(_ access: String) {
        self.accessToken = access
        kc.saveString(access, service: service, account: accessAccount)
    }

    func getAccessToken() -> String? { accessToken }
    func getRefreshToken() -> String? { refreshToken }

    func clearTokens() {
        accessToken  = nil
        refreshToken = nil
        kc.delete(service: service, account: accessAccount)
        kc.delete(service: service, account: refreshAccount)
    }

    func refresh(using service: RefreshServiceProtocol) async throws -> String {
        if let task = inFlightRefresh { return try await task.value }

        guard let rt = refreshToken, !rt.isEmpty else {
            throw URLError(.userAuthenticationRequired)
        }

        let task = Task { () throws -> String in
            defer { inFlightRefresh = nil }
            let response = try await service.refreshToken(refreshToken: rt)
            guard response.success else { throw URLError(.userAuthenticationRequired) }

            // Persist new tokens
            setTokens(access: response.data.accessToken, refresh: response.data.accessToken)
            return response.data.accessToken
        }
        inFlightRefresh = task
        return try await task.value
    }
}
