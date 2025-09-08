//
//  Orders-On-General-Pool.swift
//  LMD
//
//  Created by Naif on 25/02/1447 AH.
//
//

import SwiftUI

struct Orders_On_General_Pool_Card : View {
    @State var name : String
    @State var orderID : String
    @State var CreatedAt : String
    @State var numberOfOrders : Int?
    @State var RoadDistance : Double?
    var action: (() -> ())?
    
    private var createdDate: Date? {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return formatter.date(from: CreatedAt)
    }
    
    private var timeAgo: String {
        guard let date = createdDate else { return NSLocalizedString("unknown_time", comment: "") }
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter.localizedString(for: date, relativeTo: Date())
    }
    
    var body: some View {
        VStack {
            ZStack {
                Color.red
                
                VStack {
                    HStack {
                        VStack(spacing: 10) {
                            Image(systemName: "location.circle.fill")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.white)
                            
                            Text("\(RoadDistance ?? 0, specifier: "%.2f") km")
                                .fontWidth(.condensed)
                                .foregroundColor(.white)
                        }
                        .padding()
                        .background(.red)
                        .clipShape(Circle())
                        .padding(.leading, 6)
                        
                        VStack(alignment: .leading, spacing: 3) {
                            Text(name)
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundStyle(.red)
                            
                            Text("#\(orderID)")
                                .font(.callout)
                                .fontWeight(.regular)
                                .foregroundStyle(.secondary)
                            
                            Text(String(format: NSLocalizedString("ordered_time_ago", comment: ""), timeAgo))
                                .font(.callout)
                                .fontWeight(.regular)
                                .foregroundStyle(.secondary)
                            
                            Text(String(format: NSLocalizedString("items_in_order", comment: ""), numberOfOrders ?? 0))
                                .font(.caption)
                                .fontWeight(.regular)
                                .foregroundStyle(.secondary)
                            
                            Button(action: { action?() }) {
                                HStack {
                                    Image(systemName: "plus")
                                    Text(NSLocalizedString("add_to_your_orders", comment: ""))
                                }
                                .foregroundColor(.white)
                            }
                            .padding(.horizontal, 20)
                            .padding(.vertical, 8)
                            .background(Color("PrimaryRed"))
                            .cornerRadius(10)
                            .padding(.bottom, 10)
                        }
                        .padding(.leading, 5)
                        Spacer()
                    }
                    .background(Color.white)
                    .padding()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height * 0.2)
        }
    }
}

#Preview {
    Orders_On_General_Pool_Card(
        name: "Hanan",
        orderID: "181818",
        CreatedAt: "2025-03-16T12:00:00Z",
        numberOfOrders: 3,
        RoadDistance: 12.5
    )
}
