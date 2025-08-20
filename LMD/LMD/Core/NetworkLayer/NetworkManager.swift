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

        // Default headers
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        if let token = TokenStore.shared.accessToken {
//            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
//        }
        // Supabase API key
        request.setValue(
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6IndieWV3b2RyaXp6ZWNtaGtjdWlsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTU1MjI5NDksImV4cCI6MjA3MTA5ODk0OX0.mBq9iQRLKeEXg1qV1VGMahw3LmNiP30-rKfCqoDIDEU",
            forHTTPHeaderField: "apikey"
        )


        // Custom headers
        headers?.forEach { request.setValue($0.value, forHTTPHeaderField: $0.key) }

        // Request body
        if let body = body {
            request.httpBody = try JSONEncoder().encode(body)
        }

        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.unknown
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
}
