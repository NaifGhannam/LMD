//
//  DeliveryLogCard.swift
//  LMD
//
//  Created by Naif on 11/03/1447 AH.
import SwiftUI

struct DeliveryLogCard: View {
    let order: Order   // Pass the order
    
    var body: some View {
        HStack {
            OrderStatusEnum(rawValue: order.statusID)?.statusImage
                .resizable()
                .frame(width: 26, height: 26)
                .foregroundColor(order.statusID == 8 ? Color("PrimaryGreen") : Color.red)
            
            VStack(alignment: .leading) {
                Text(order.deliveryTime.formattedDayMonthYearTime())
                       .font(.system(size: 18))
                
                Text(order.orderNumber)
                    .foregroundColor(.gray)
            }
            .padding(.horizontal, 14)
            
            Spacer()
            
            Text(TimeAgoFormatter2.shared.timeAgo(from: order.deliveryTime.toDate()))
                .foregroundColor(Color("PrimaryGreen"))
                .bold()
                
           // Divider()
        }
        .padding(.vertical)
    }
}
extension String {
    func formattedDayMonthYearTime() -> String {
        let isoFormatter = ISO8601DateFormatter()
        let displayFormatter = DateFormatter()
        displayFormatter.dateFormat = "d/M/yyyy h:mm a"  // Example: 3/9/2025 2:45 PM
        
        if let date = isoFormatter.date(from: self) {
            return displayFormatter.string(from: date)
        }
        return self // fallback if parsing fails
    }
    func toDate() -> Date? {
           let formatter = ISO8601DateFormatter()
           return formatter.date(from: self)
       }
}
import Foundation

class TimeAgoFormatter2 {
    static let shared = TimeAgoFormatter2()
    private init() {}
    
    func timeAgo(from date: Date?) -> String {
        guard let date = date else { return "Unknown" }
        
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full  // e.g., "30 minutes ago"
        
        return formatter.localizedString(for: date, relativeTo: Date())
    }
}
