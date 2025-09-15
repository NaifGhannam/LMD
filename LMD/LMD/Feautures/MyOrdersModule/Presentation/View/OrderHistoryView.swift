//
//  OrderHistoryView.swift
//  LMD
//
//  Created by Naif on 10/03/1447 AH.
//

import SwiftUI
import PDFKit

struct OrderHistoryView: View {
    @StateObject var vm: MyOrdersViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            //  Top bar with title + menu
            HStack {
                Text(NSLocalizedString("order_history_title", comment: "Order History page title"))
                    .font(.title2)
                    .foregroundColor(.white)
                Spacer()
                Menu {
                    // Filter
                    Menu(NSLocalizedString("filter_by_status", comment: "Filter orders by status")) {
                        statusToggle(NSLocalizedString("status_delivered", comment: ""), id: OrderStatusEnum.done.rawValue)
                        statusToggle(NSLocalizedString("status_canceled", comment: ""), id: OrderStatusEnum.canceled.rawValue)
                        statusToggle(NSLocalizedString("status_failed", comment: ""), id: OrderStatusEnum.failed.rawValue)
                    }
                    
                    // Sort
                    Menu(NSLocalizedString("sort_orders", comment: "Sort orders menu")) {
                        Button(NSLocalizedString("oldest_to_newest", comment: "")) { vm.sortAscending = true }
                        Button(NSLocalizedString("newest_to_oldest", comment: "")) { vm.sortAscending = false }
                    }
                    
                    // Export PDF
                    Button(NSLocalizedString("export_as_pdf", comment: "Export filtered orders as PDF")) {
                        if let url = vm.exportFilteredOrdersAsPDF() {
                            sharePDF(url: url)
                        }
                    }
                } label: {
                    Image(systemName: "ellipsis.circle")
                        .foregroundColor(.white)
                        .font(.title2)
                }
            }
            .padding()
            .background(Color.red)
            
            // Orders list
            ScrollView {
                LazyVStack {
                    ForEach(vm.displayedOrders, id: \.orderID) { order in
                        OrderHistoryCard(
                            price: 343,
                            Number: order.orderNumber,
                            name: order.customerName,
                            time: order.orderDate
                        )
                        .padding(.bottom ,4)
                        .onAppear {
                            Task {
                                await vm.loadMoreOrdersIfNeeded(currentOrder: order)
                            }
                        }
                    }
                    
                    if vm.isLoading {
                        ProgressView(NSLocalizedString("loading_more", comment: "Loading more orders..."))
                            .padding()
                    }
                }
            }
        }
        .task {
            await vm.fetchMyOrders()
        }
    }
    
    // Helper for status filter
    @ViewBuilder
    private func statusToggle(_ name: String, id: Int) -> some View {
        Button {
            if vm.selectedStatuses.contains(id) {
                vm.selectedStatuses.remove(id)
            } else {
                vm.selectedStatuses.insert(id)
            }
        } label: {
            Label(name, systemImage: vm.selectedStatuses.contains(id) ? "checkmark.circle.fill" : "circle")
        }
    }
    
    // Show share sheet for PDF
    private func sharePDF(url: URL) {
        let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootVC = scene.windows.first?.rootViewController {
            rootVC.present(activityVC, animated: true, completion: nil)
        }
    }
}
