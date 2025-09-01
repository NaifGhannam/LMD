//
//  RefreshViewModel.swift
//  LMD
//
//  Created by Tahani on 09/03/1447 AH.
//

import Foundation

@MainActor
class RefreshViewModel: ObservableObject {
    
    static let shared = RefreshViewModel()
    
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var message: String?
    
    private let refreshService: RefreshServiceProtocol
    
    init(refreshService: RefreshServiceProtocol = RefreshService()) {
        self.refreshService = refreshService
    }
    
    func refresh(refreshToken: String) async {
        
        self.isLoading = true
        self.errorMessage = nil
        
        do {
            
            print("--------------------------------------------")
            let result = try await refreshService.refreshToken(refreshToken: refreshToken)
            print(result.success)
            print("--------------------------------------------")
                        
        } catch {
            self.errorMessage = error.localizedDescription
        }
        
        self.isLoading = false
    }
}
