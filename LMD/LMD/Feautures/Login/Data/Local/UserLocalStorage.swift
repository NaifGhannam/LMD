//
//  UserLocalStorage.swift
//  LMD
//
//  Created by Naif on 24/03/1447 AH.
//

import Foundation


final class UserLocalStorage {
    private enum StorageKey {
        static let loggedInUser = "loggedInUser"
        static let accessToken = "accessToken"
        static let refreshToken = "refreshToken"
        static let userId = "userId"
    }

    func saveUser(_ user: User) {
        if let encoded = try? JSONEncoder().encode(user) {
            UserDefaults.standard.set(encoded, forKey: StorageKey.loggedInUser)
        }
    }

    func loadUser() -> User? {
        guard let data = UserDefaults.standard.data(forKey: StorageKey.loggedInUser),
              let user = try? JSONDecoder().decode(User.self, from: data)
        else { return nil }
        return user
    }

    func saveTokens(access: String, refresh: String, userId: String) {
        let service = Bundle.main.bundleIdentifier ?? "com.lmd.app"
        KeychainHelper.shared.save(access, service: service, account: StorageKey.accessToken)
        KeychainHelper.shared.save(refresh, service: service, account: StorageKey.refreshToken)
        KeychainHelper.shared.save(userId, service: service, account: StorageKey.userId)
    }

    func clear() {
        UserDefaults.standard.removeObject(forKey: StorageKey.loggedInUser)
        let service = Bundle.main.bundleIdentifier ?? "com.lmd.app"
        KeychainHelper.shared.delete(service: service, account: StorageKey.accessToken)
        KeychainHelper.shared.delete(service: service, account: StorageKey.refreshToken)
        KeychainHelper.shared.delete(service: service, account: StorageKey.userId)
    }
}
