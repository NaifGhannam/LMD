//
//  MyOrdersViewModel.swift
//  LMD
//
//  Created by Tahani on 25/02/1447 AH.
//

import Foundation
import SwiftUI
import PDFKit


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
    
    
    @Published var sortAscending: Bool = true
    @Published var selectedStatuses: Set<Int> = []

    
    private let serviceName = Bundle.main.bundleIdentifier ?? "com.lmd.app"
    private let orderService: MyOrdersServiceProtocol
    private var currentPage = 1
    
    
    
    init(orderService: MyOrdersServiceProtocol = MyOrdersService()) {
        self.orderService = orderService
    }
    
    var displayedOrders: [Order] {
           var filtered = orders
           
           // Filter by selected statuses
           if !selectedStatuses.isEmpty {
               filtered = filtered.filter { selectedStatuses.contains($0.statusID) }
           }
           
           // Search by order number
           let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
           if !query.isEmpty {
               filtered = filtered.filter {
                   $0.orderNumber.localizedCaseInsensitiveContains(query)
               }
           }
           
           // Sort by order date
           filtered.sort {
               if sortAscending {
                   return $0.orderDate < $1.orderDate
               } else {
                   return $0.orderDate > $1.orderDate
               }
           }
           
           return filtered
       }
    //  Generate PDF from filtered orders
      func exportFilteredOrdersAsPDF() -> URL? {
          let pdfMetaData = [
              kCGPDFContextCreator: "LMD App",
              kCGPDFContextAuthor: "Your Company",
              kCGPDFContextTitle: "Filtered Orders"
          ]
          
          let format = UIGraphicsPDFRendererFormat()
          format.documentInfo = pdfMetaData as [String: Any]
          
          // temporary file path
          let fileName = "FilteredOrders.pdf"
          let tempDir = FileManager.default.temporaryDirectory
          let fileURL = tempDir.appendingPathComponent(fileName)
          
          let pageWidth: CGFloat = 595.2  // A4 width
          let pageHeight: CGFloat = 841.8 // A4 height
          let renderer = UIGraphicsPDFRenderer(bounds: CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight), format: format)
          
          do {
              try renderer.writePDF(to: fileURL, withActions: { context in
                  context.beginPage()
                  
                  var yPosition: CGFloat = 20
                  let leftMargin: CGFloat = 20
                  
                  // Title
                  let title = "Filtered Orders (\(displayedOrders.count))"
                  title.draw(at: CGPoint(x: leftMargin, y: yPosition), withAttributes: [
                      .font: UIFont.boldSystemFont(ofSize: 20)
                  ])
                  yPosition += 40
                  
                  for order in displayedOrders {
                      let text = """
                      Order #: \(order.orderNumber)
                      Customer: \(order.customerName)
                      Date: \(order.orderDate)
                      Status: \(order.statusID)
                      ----------------------------
                      """
                      text.draw(at: CGPoint(x: leftMargin, y: yPosition), withAttributes: [
                          .font: UIFont.systemFont(ofSize: 14)
                      ])
                      
                      yPosition += 80
                      
                      //  Start a new page if we exceed the page height
                      if yPosition > pageHeight - 100 {
                          context.beginPage()
                          yPosition = 20
                      }
                  }
              })
              
              print("✅ PDF created at: \(fileURL)")
              return fileURL
          } catch {
              print("❌ Could not create PDF file: \(error)")
              return nil
          }
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
