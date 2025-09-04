//
//  MyOrdersViewModel.swift
//  LMD
//
//  Created by Tahani on 25/02/1447 AH.
//

import Foundation
import SwiftUI

@MainActor
class MyOrdersViewModel: ObservableObject {
    
    @Published var searchText: String = ""
    @Published var orders: [Order] = []
    @Published var users: [Users] = []
    @Published var ordersData: OrdersData?
    @Published var pagination: Paginations?
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var message: String?
    
    private let serviceName = Bundle.main.bundleIdentifier ?? "com.lmd.app"
    private let orderService: MyOrdersServiceProtocol
    private var currentPage = 1
    
    init(orderService: MyOrdersServiceProtocol = MyOrdersService()) {
        self.orderService = orderService
    }
    
    func fetchMyOrders() async {
        currentPage = 1
        await loadOrders(page: currentPage, reset: true)
    }
    
    func loadMoreOrdersIfNeeded(currentOrder order: Order) async {
        guard let pagination = pagination else { return }
        guard pagination.hasNextPage else { return }
        
        if orders.last?.orderID == order.orderID {
            currentPage += 1
            await loadOrders(page: currentPage, reset: false)
        }
    }
    
    private func loadOrders(page: Int, reset: Bool) async {
        guard !isLoading else { return }
        isLoading = true
        defer { isLoading = false }
        
        do {
            let result = try await orderService.getMyOrders(page: page, limit: 100)
            print(result.data.orders.count)
            print("----------------------------------")
            if reset {
                self.orders = result.data.orders
            } else {
                self.orders.append(contentsOf: result.data.orders)
            }
            self.ordersData = result.data
            self.pagination = result.data.pagination
            
            
            
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }
    
//    func updateOrderStatues(orderId: String, statusId: Int, assignedAgentId: String? = nil) async {
//        
//        self.isLoading = true
//        self.errorMessage = nil
//        
//        do {
//            
//            let result = try await orderService.updateOrderStatues(orderId: orderId, statusId: statusId, assignedAgentId: assignedAgentId)
//            
//            print(result.success)
//            
//        } catch {
//            self.errorMessage = error.localizedDescription
//        }
//        self.isLoading = false
//    }
    
    func updateOrderStatues(orderId: String, statusId: Int, assignedAgentId: String? = nil) async {
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }

        do {
            let result = try await orderService.updateOrderStatues(
                orderId: orderId,
                statusId: statusId,
                assignedAgentId: assignedAgentId
            )

            // If your API returns the updated order, prefer using that.
            // Otherwise, do an optimistic local update like below.
            if result.success {
                if let idx = orders.firstIndex(where: { $0.orderID == orderId }) {
                    var updated = orders[idx]
                    updated.statusID = statusId
                    if let assignedAgentId { updated.assignedAgentID = assignedAgentId }
                    // If you also need to update status name, do it here:
                    // updated.orderStatuses.statusName = ...
                    
                    orders[idx] = updated  // <-- replace to trigger UI update
                } else {
                    // Fallback: if not found, refresh page 1 (optional)
                    await fetchMyOrders()
                }
                message = "Order updated."
            } else {
                errorMessage = "Failed to update order."
            }
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    
    func getAllUsers() async {
        
        self.isLoading = true
        self.errorMessage = nil
        
        do {
            
            let result = try await orderService.getAllUsers()
            self.users = result.data
            
        } catch {
            self.errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    func filterData() -> [Order] {
        let base: [Order] = {
            if let userId = KeychainHelper.shared.read(service: serviceName, account: "userId") {
                return orders.filter { $0.assignedAgentID == userId }
            } else {
                return orders
            }
        }()
        
        let filtered = base.filter { order in
            order.statusID != OrderStatusEnum.canceled.rawValue &&
            order.statusID != OrderStatusEnum.failed.rawValue &&
            order.statusID != OrderStatusEnum.done.rawValue
        }
        
        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !query.isEmpty else { return filtered }
        return filtered.filter { order in
            String(describing: order.orderNumber)
                .localizedCaseInsensitiveContains(query)
        }
    }
}
