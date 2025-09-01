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

    //var authSession: AuthSession?
    
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
        
        request.setValue("Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhMGRiNWI1NC04ODhkLTRhNzItYTkxYy04ZDA0YzRjNDgzYmEiLCJlbWFpbCI6InRheW1hbkBudGdjbGFyaXR5LmNvbSIsImV4cCI6MTc1NjcxMjY5NCwiaWF0IjoxNzU2NzA5MDk0LCJ0eXBlIjoiYWNjZXNzIn0.A-8jl2QoywBRGrbUy8LKkgFRahJ0oDLYxWOf2L4T67I", forHTTPHeaderField: "Authorization")

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
        
        if httpResponse.statusCode == 401 {
           Task {
               await RefreshViewModel().refresh(refreshToken: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhMGRiNWI1NC04ODhkLTRhNzItYTkxYy04ZDA0YzRjNDgzYmEiLCJleHAiOjE3NTkzMDEwOTQsImlhdCI6MTc1NjcwOTA5NCwidHlwZSI6InJlZnJlc2gifQ._XHRF95MKTJNiJU3UVrTKOylubGrVxo68aez8v6896A")
            }
        }
        
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingFailed
        }
    }
}
