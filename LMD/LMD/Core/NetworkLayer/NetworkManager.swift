//
//  NetworkManager.swift
//  LMD
//
//  Created by Naif on 24/02/1447 AH.
//

import Foundation

final class NetworkManager {
    static let shared = NetworkManager()
    private init() {}

    private let serviceName = Bundle.main.bundleIdentifier ?? "com.lmd.app"

    func request<T: Decodable>(
        endpoint: APIEndpoint,
        body: Encodable? = nil,
        headers: [String: String]? = nil
    ) async throws -> T {

        guard let url = URL(string: endpoint.url) else {
            throw NetworkError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue

        var allHeaders: [String: String] = ["Content-Type": "application/json"]

        if endpoint.requiresAuth {
            if let tokenData = KeychainHelper.shared.read(service: serviceName, account: "accessToken") {
                allHeaders["Authorization"] = "Bearer \(tokenData)"
            } else {
                throw NetworkError.unauthorized
            }
        } else {
            let initialToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imtnb213eWtzeGpxdGNqd2x6YnNwIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTU3ODQ0NTEsImV4cCI6MjA3MTM2MDQ1MX0.g0JTJ4fftJum44D3gDJHwnoXK0XBLmWnsRbQcSVO5zs"
            
            allHeaders["Authorization"] = "Bearer \(initialToken)"
        }

        if let headers = headers {
            for (k, v) in headers { allHeaders[k] = v }
        }
        
        for (k, v) in allHeaders { request.setValue(v, forHTTPHeaderField: k) }

        if let body = body {
            request.httpBody = try JSONEncoder().encode(body)
        }

        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else { throw NetworkError.unknown }

        if httpResponse.statusCode == 401, endpoint.requiresAuth {
            print("⚠️ [HTTP] 401 received. Attempting refresh…")
            try await refreshAccessToken()

            if let newAccess = KeychainHelper.shared.read(service: serviceName, account: "accessToken") {
                request.setValue("Bearer \(newAccess)", forHTTPHeaderField: "Authorization")
            } else {
                throw NetworkError.unauthorized
            }

            let (data2, response2) = try await URLSession.shared.data(for: request)
            guard let http2 = response2 as? HTTPURLResponse, (200..<300).contains(http2.statusCode) else {
                let code = (response2 as? HTTPURLResponse)?.statusCode ?? -1
                print("❌ [HTTP] Retry failed with status: \(code)")
                throw NetworkError.requestFailed(code)
            }

            do { return try JSONDecoder().decode(T.self, from: data2) }
            catch {
                throw NetworkError.decodingFailed
            }
        }

        guard 200..<300 ~= httpResponse.statusCode else {
            throw NetworkError.requestFailed(httpResponse.statusCode)
        }

        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingFailed
        }
    }

    private func refreshAccessToken() async throws {
        print("------------------------------------------------------")
        print("🔄 [Auth] refreshAccessToken() called")

        guard let refreshToken = KeychainHelper.shared.read(service: serviceName, account: "refreshToken") else {
            print("❌ [Auth] No refresh token in Keychain")
            throw NetworkError.unauthorized
        }
        
        do {
            let resp = try await RefreshService().refreshToken(refreshToken: refreshToken)
            print("✅ [Auth] Refresh succeeded; new access expires at: \(resp.data.expiresAt)")

            // Save tokens
            KeychainHelper.shared.save(resp.data.accessToken,  service: serviceName, account: "accessToken")
            KeychainHelper.shared.save(resp.data.refreshToken, service: serviceName, account: "refreshToken")
            
        } catch {
            print("❌ [Auth] Refresh failed with error: \(error)")
            throw error
        }
    }
}
