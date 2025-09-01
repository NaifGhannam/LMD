//
//  KeychainHelper.swift
//  LMD
//
//  Created by Naif on 24/02/1447 AH.
//
//import Foundation
//import Security
//
//final class KeychainHelper {
//    static let shared = KeychainHelper()
//    private init() {}
//    
//    func save(_ data: String, service: String, account: String) {
//        let query: [String: Any] = [
//            kSecClass as String       : kSecClassGenericPassword,
//            kSecAttrService as String : service,
//            kSecAttrAccount as String : account,
//            kSecValueData as String   : data
//        ]
//        
//        // Delete old item if exists
//        SecItemDelete(query as CFDictionary)
//        
//        // Add new item
//        SecItemAdd(query as CFDictionary, nil)
//    }
//    
//    func read(service: String, account: String) -> String {
//        let query: [String: Any] = [
//            kSecClass as String       : kSecClassGenericPassword,
//            kSecAttrService as String : service,
//            kSecAttrAccount as String : account,
//            kSecReturnData as String  : true,
//            kSecMatchLimit as String  : kSecMatchLimitOne
//        ]
//        
//        var result: String?
//        SecItemCopyMatching(query as CFDictionary, &result)
//        return result
//    }
//    
//    func delete(service: String, account: String) {
//        let query: [String: Any] = [
//            kSecClass as String       : kSecClassGenericPassword,
//            kSecAttrService as String : service,
//            kSecAttrAccount as String : account
//        ]
//        SecItemDelete(query as CFDictionary)
//    }
//}



import Foundation
import Security

final class KeychainHelper {
    static let shared = KeychainHelper()
    private init() {}
    
    // MARK: - Save
    func save(_ value: String, service: String, account: String) {
        guard let data = value.data(using: .utf8) else { return }
        
        let query: [String: Any] = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrService as String : service,
            kSecAttrAccount as String : account
        ]
        
        // Delete old item if exists
        SecItemDelete(query as CFDictionary)
        
        // Add new item
        let attributes: [String: Any] = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrService as String : service,
            kSecAttrAccount as String : account,
            kSecValueData as String   : data
        ]
        
        SecItemAdd(attributes as CFDictionary, nil)
    }
    
    // MARK: - Read
    func read(service: String, account: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrService as String : service,
            kSecAttrAccount as String : account,
            kSecReturnData as String  : true,
            kSecMatchLimit as String  : kSecMatchLimitOne
        ]
        
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        
        guard status == errSecSuccess,
              let data = item as? Data,
              let string = String(data: data, encoding: .utf8) else {
            return nil
        }
        
        return string
    }
    
    // MARK: - Delete
    func delete(service: String, account: String) {
        let query: [String: Any] = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrService as String : service,
            kSecAttrAccount as String : account
        ]
        
        SecItemDelete(query as CFDictionary)
    }
}

