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
    
    private let serviceName = "com.lmd.app"
    
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
        var allHeaders: [String: String] = [
            "Content-Type": "application/json"
        ]
        
        // Authorization
        if endpoint.requiresAuth {
            if let tokenData = KeychainHelper.shared.read(service: serviceName, account: "accessToken") {
                allHeaders["Authorization"] = "Bearer \(tokenData)"
            }
            else {
                throw NetworkError.unauthorized
            }
        } else {
            let initialToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imtnb213eWtzeGpxdGNqd2x6YnNwIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTU3ODQ0NTEsImV4cCI6MjA3MTM2MDQ1MX0.g0JTJ4fftJum44D3gDJHwnoXK0XBLmWnsRbQcSVO5zs"
            allHeaders["Authorization"] = "Bearer \(initialToken)"
        }

        
//        // Default headers
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        
//        request.setValue("Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhMGRiNWI1NC04ODhkLTRhNzItYTkxYy04ZDA0YzRjNDgzYmEiLCJlbWFpbCI6InRheW1hbkBudGdjbGFyaXR5LmNvbSIsImV4cCI6MTc1NjY0MTU5MCwiaWF0IjoxNzU2NjM3OTkwLCJ0eXBlIjoiYWNjZXNzIn0.8cwsWqhBqQyz3LCK3bw7R3q3M34HNFy1Z1Dyt6ya1cc", forHTTPHeaderField: "Authorization")

        
        // Merge custom headers
        if let headers = headers {
            for (key, value) in headers {
                allHeaders[key] = value
            }
        }
        
        for (key, value) in allHeaders {
            request.setValue(value, forHTTPHeaderField: key)
        }
        
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
