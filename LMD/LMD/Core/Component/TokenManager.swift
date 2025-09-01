//
//  TokenManager.swift
//  LMD
//
//  Created by Naif on 09/03/1447 AH.
//


import Foundation
import Security

/// A simple Keychain helper to store/retrieve/delete tokens
final class TokenManager {
    
    static let shared = TokenManager()
    private init() {}
    
    private let service = Bundle.main.bundleIdentifier ?? "com.example.app"
    private let account = "accessToken"
    
    // MARK: - Save Token
    func saveToken(_ token: String) -> Bool {
        guard let tokenData = token.data(using: .utf8) else { return false }
        
        // Check if token already exists
        if getToken() != nil {
            // Update existing token
            let query: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrService as String: service,
                kSecAttrAccount as String: account
            ]
            
            let attributes: [String: Any] = [
                kSecValueData as String: tokenData
            ]
            
            let status = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)
            return status == errSecSuccess
        } else {
            // Add new token
            let query: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrService as String: service,
                kSecAttrAccount as String: account,
                kSecValueData as String: tokenData
            ]
            
            let status = SecItemAdd(query as CFDictionary, nil)
            return status == errSecSuccess
        }
    }
    
    // MARK: - Retrieve Token
    func getToken() -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var item: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        
        guard status == errSecSuccess,
              let tokenData = item as? Data,
              let token = String(data: tokenData, encoding: .utf8) else {
            return nil
        }
        return token
    }
    
    // MARK: - Delete Token
    func deleteToken() -> Bool {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        return status == errSecSuccess
    }
}
