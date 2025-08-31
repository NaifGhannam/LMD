//
//  MyOrdersViewModel.swift
//  LMD
//
//  Created by Tahani on 25/02/1447 AH.
//

import Foundation

@MainActor
class MyOrdersViewModel: ObservableObject {
    
    @Published var searchText: String = ""
    @Published var orders: [Order] = []
    @Published var users: [Users] = []
    @Published var ordersData: OrdersData?
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var message: String?
    
    private let orderService: MyOrdersServiceProtocol
    
    init(orderService: MyOrdersServiceProtocol = MyOrdersService()) {
        self.orderService = orderService
    }
    
    func fetchMyOrders() async {
        
        self.isLoading = true
        self.errorMessage = nil
        
        do {
            
            let result = try await orderService.getMyOrders()
            self.orders = result.data.orders
            self.ordersData = result.data
            for item in result.data.orders {
                print(item.orderID)
            }
            
        } catch {
            self.errorMessage = error.localizedDescription
        }
        
        self.isLoading = false
    }
    
    func updateOrderStatues(orderId: String, statusId: Int, assignedAgentId: String? = nil) async {
        
        self.isLoading = true
        self.errorMessage = nil
        
        do {
            
            _ = try await orderService.updateOrderStatues(orderId: orderId, statusId: statusId, assignedAgentId: assignedAgentId)
            
        } catch {
            self.errorMessage = error.localizedDescription
        }
        
        self.isLoading = false
    }
    
    func getAllUsers() async {
        
        self.isLoading = true
        self.errorMessage = nil
        
        do {
            
            print("-------------------------------------------------------")
            let result = try await orderService.getAllUsers()
            self.users = result.data
            print(result.success)
        
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
