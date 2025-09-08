//
//  DetailsCard.swift
//  LMD
//
//  Created by Tahani on 25/02/1447 AH.
//
//
import SwiftUI

struct DetailsCard: View {
    
    let order: Order
    @ObservedObject var viewModel: MyOrdersViewModel
    @State private var pendingAction: OrderAction?
    @State private var isUpdating = false
    @State private var isShowingSheet = false
    @State var isShowDetailsBtn = true
    @State private var selectedUser: UUID? = nil
    @Environment(\.openURL) private var openURL
    
    var body: some View {
        VStack {
            HStack {
                
                VStack(spacing: 7) {
                    Image(systemName: "location.north.fill")
                    
                    Text("\(order.distanceKm ?? 0.0, specifier: "%.1f")")
                }
                .foregroundColor(.white)
                .padding()
                .background(Color("PrimaryRed"))
                .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: 0) {
                    
                    Text("# \(order.orderNumber)")
                        .font(.system(size: 14))
                        .foregroundColor(.gray.opacity(0.7))
                        .bold()
                    
                    Text(order.customerName)
                    
                    Text(NSLocalizedString("new_order", comment: ""))
                        .foregroundColor(Color("PrimaryRed"))
                }
                
                Spacer()
                
                VStack {
                    
                    if order.statusID != OrderStatusEnum.done.rawValue {
                        
                        HStack {
                            
                            Text(order.orderStatuses.statusName)
                                .foregroundColor(Color("PrimaryGreen"))
                                .bold()
                            
                            Menu {
                                Button(action: {
                                    Task {
                                        await viewModel.updateOrderStatues(orderId: order.orderID, statusId: OrderStatusEnum.canceled.rawValue)
                                    }
                                }) {
                                    Text(NSLocalizedString("cancel_action", comment: ""))
                                }
                                
                                Button(action: {
                                    isShowingSheet.toggle()
                                }) {
                                    Text(NSLocalizedString("reassign_action", comment: ""))
                                }
                            } label: {
                                Image("more")
                                    .resizable()
                                    .frame(width: 15, height: 15)
                            }
                        }
                        
                        Spacer()
                            .frame(height: 20)
                    }
                    
                    HStack(spacing: 1) {
                        Text("100.0")
                            .font(.system(size: 22, weight: .bold))
                        Text("LE")
                            .foregroundColor(.gray)
                    }
                }
            }
            
            HStack {
                
                if isShowDetailsBtn {
                    
                    NavigationLink(destination: OrderDetailsView(order: order).environmentObject(GeneralPoolViewModel())) {
                        
                        Text(NSLocalizedString("order_details_button", comment: ""))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(8)
                            .background(Color("PrimaryRed"))
                            .cornerRadius(10)
                    }
                }
                
                if order.statusID != OrderStatusEnum.canceled.rawValue,
                   let act = action(for: order.statusID) {
                    
                    PrimaryActionButton(title: act.title) {
                        pendingAction = act
                    }
                    .alert(item: $pendingAction) { act in
                        Alert(
                            title: Text(act.alertTitle),
                            message: Text(act.alertMessage),
                            primaryButton: .default(Text(NSLocalizedString("ok_button", comment: "")), action: {
                                Task { await run(act) }
                            }),
                            secondaryButton: .cancel()
                        )
                    }
                }
            }
            .padding(.bottom)
            
            if order.statusID == OrderStatusEnum.pickup.rawValue || order.statusID == OrderStatusEnum.start.rawValue {
                
                CustomButton(title: NSLocalizedString("delivery_failed_button", comment: "")) {
                    Task {
                        await viewModel.updateOrderStatues(orderId: order.orderID, statusId: OrderStatusEnum.failed.rawValue)
                    }
                }
            }
            
            CustomButton(showIcon: true, title: NSLocalizedString("call_button", comment: "")) {
                call("+966 55 123 4567")
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.white)
        .cornerRadius(5)
        .shadow(radius: 3)
        .sheet(isPresented: $isShowingSheet) {
            
            List(viewModel.users, id: \.id) { user in
                Button(user.name) {
                    isShowingSheet = false
                    Task {
                        await viewModel.updateOrderStatues(
                            orderId: order.orderID,
                            statusId: OrderStatusEnum.added.rawValue,
                            assignedAgentId: user.id
                        )
                    }
                }
                .foregroundColor(.black)
            }
            .presentationDetents([.height(UIScreen.main.bounds.height * 0.5)])
        }
        .task {
            await viewModel.getAllUsers()
        }
    }
    
    @MainActor
    private func run(_ act: OrderAction) async {
        isUpdating = true
        defer { isUpdating = false }
        do {
            let _ = await viewModel.updateOrderStatues(
                orderId: order.orderID,
                statusId: act.nextStatus.rawValue
            )
        }
    }
    
    private func call(_ raw: String) {
        let digits = raw.filter { "+0123456789".contains($0) } // sanitize
        guard let url = URL(string: "tel://\(digits)"),
              UIApplication.shared.canOpenURL(url)     // real device only
        else { return }
        openURL(url)
    }
}
