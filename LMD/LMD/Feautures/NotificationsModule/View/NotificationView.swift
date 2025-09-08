//
//  NotificationView.swift
//  LMD
//
//  Created by Tahani on 16/03/1447 AH.
//

import SwiftUI

struct NotificationView: View {
    
    @State private var selectedTab: NotificationTab = .all
    init () {
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color("PrimaryRed"))
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
    }
    
    let mockNotifications: [NotificationItem] = [
        NotificationItem(title: "Order No 1234 Added", timeAgo: "3 Days", type: .orders),
        NotificationItem(title: "Order No 5678 Delivered", timeAgo: "1 Day", type: .orders),
        NotificationItem(title: "Wallet recharged with $50", timeAgo: "2 Hours", type: .wallet),
        NotificationItem(title: "System maintenance scheduled", timeAgo: "Yesterday", type: .other),
        NotificationItem(title: "New feature released!", timeAgo: "1 Week", type: .other)
    ]
    
    var body: some View {
        VStack {
            HStack {
                Text("Notifications")
                    .font(.system(size: 24, weight: .semibold))
                Spacer()
            }
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color("PrimaryRed"))
            
            Picker("", selection: $selectedTab) {
                ForEach(NotificationTab.allCases, id: \.self) { tab in
                    
                    Text(tab.rawValue)
                    
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            List(filterNotifications(tab: selectedTab)) { notification in
                
                HStack {
                    Text(notification.title)
                        .font(.system(size: 18))
                    Spacer()
                    Text(notification.timeAgo)
                        .foregroundColor(.gray)
                }
            }
            .listStyle(.plain)
            
            Spacer()
        }
    }
    
    func filterNotifications(tab: NotificationTab) -> [NotificationItem] {
        if tab == .all {
            return mockNotifications
        } else {
            return mockNotifications.filter { $0.type == tab }
        }
    }
}

#Preview {
    NotificationView()
}

enum NotificationTab: String, CaseIterable {
    case all = "All"
    case orders = "Orders"
    case wallet = "Wallet"
    case other = "Other"
}

struct NotificationItem: Identifiable {
    let id = UUID()
    let title: String
    let timeAgo: String
    let type: NotificationTab
}
