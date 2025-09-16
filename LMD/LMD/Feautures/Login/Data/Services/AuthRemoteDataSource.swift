//
//  AuthRemoteDataSource.swift
//  LMD
//
//  Created by Naif on 24/03/1447 AH.
//


//// Data/Services/AuthRemoteDataSource.swift
//final class AuthRemoteDataSource {
//    func login(request: LoginRequestDTO) async throws -> LoginResponseDTO {
//        // استدعاء API حقيقي أو محاكي
//        return try await NetworkManager.shared.request(endpoint: .login(request))
//        fatalError("Implement API call")
//    }
//
//    func logout() async throws -> Bool {
//        // استدعاء API لتسجيل الخروج
//        fatalError("Implement API call")
//    }
//}
// Data/Services/AuthRemoteDataSource.swift
import Foundation

final class AuthRemoteDataSource {

    func login(request: LoginRequestDTO) async throws -> LoginResponseDTO {
        // 🔹 يستدعي دالة الطلب العامة مع نوع الاستجابة
        return try await NetworkManager.shared.request(
            endpoint: .login,
            body: request   // يجب أن يكون LoginRequestDTO: Encodable
        )
    }

    func logout() async throws -> Bool {
        // 🔹 إذا كان الـAPI يرجع كائن مثل {"success": true}
        struct LogoutResponse: Decodable { let success: Bool }

        let response: LogoutResponse = try await NetworkManager.shared.request(
            endpoint: .Logout
        )
        return response.success
    }
}
