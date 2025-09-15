//
//  OrderHistory.swift
//  LMD
//
//  Created by Naif on 10/03/1447 AH.
//

import SwiftUI

struct OrderHistoryCard : View {
    @State var price : Double = 343.0
    @State var Number : String = "811"
    @State var name : String = "Naif"
    @State var time : String = ""
    
    
    var body: some View {
        
        VStack (alignment : .leading){
            HStack{
                Spacer()
                
                Text("\(price.isFinite ? String(format: "%.1f", price) : "0") $")
                    .bold()
                    .padding(.trailing, 10)

            }
            HStack{
                
                
                VStack(alignment: .leading){
                    
                    
                    
                    Text("\(Number)")
                        .foregroundStyle(.secondary)
                    Text("\(name)")
                    
                    Text(TimeAgoFormatter.shared.timeAgo(from: time))
                        .foregroundStyle(.secondary)

                    
                    
                }
                .padding(.leading ,7)
                Spacer()
                
            }
        }
        .padding(.vertical, 6)
               .frame(maxWidth: .infinity)
               .background(Color.white)
               .cornerRadius(0)          // Rounded corners for better shadow
               .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 1) // Shadow outside
               .padding(.horizontal, 6)   // Outer padding

    }
}

#Preview {
    OrderHistoryCard()
}
import Foundation

struct TimeAgoFormatter {
    
    static let shared = TimeAgoFormatter()
    
    private let isoFormatter: ISO8601DateFormatter
    private let componentsFormatter: DateComponentsFormatter
    
    private init() {
        isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds] // Supports ISO8601 format
        
        componentsFormatter = DateComponentsFormatter()
        componentsFormatter.unitsStyle = .full // e.g., "5 hours, 12 minutes ago"
        componentsFormatter.allowedUnits = [.day, .hour, .minute] // Show days, hours, and minutes
        componentsFormatter.maximumUnitCount = 2 // Show up to two units, e.g., "5 days, 3 hours"
        componentsFormatter.zeroFormattingBehavior = .dropAll
    }
    
    /// Converts an ISO8601 date string to a "time ago" string
    func timeAgo(from isoDate: String) -> String {
        guard let date = isoFormatter.date(from: isoDate) else { return "" }
        let interval = Date().timeIntervalSince(date)
        guard let formatted = componentsFormatter.string(from: interval) else { return "" }
        return "\(formatted)"
    }
}
