//
//  MyOrdersViewModel.swift
//  LMD
//
//  Created by Tahani on 25/02/1447 AH.
//

import Foundation

class MyOrdersViewModel: ObservableObject {
    
    @Published var searchText: String = ""
    @Published var orders: [Order] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let orderService: MyOrdersServiceProtocol
    
    init(orderService: MyOrdersServiceProtocol = MyOrdersService()) {
        self.orderService = orderService
    }
    
    func fetchMyOrders() async {
        
        isLoading = true
        errorMessage = nil
        
        do {
            
            let result = try await orderService.getMyOrders(id: 1)
            self.orders = result.orders
            
        } catch {
            self.errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    func filterData() -> [Order] {
        
        if searchText.isEmpty {
            return orders
        } else {
            return orders.filter { $0.orderNumber.contains(searchText) }
        }
    }
}
