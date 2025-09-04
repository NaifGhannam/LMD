//
//  OrderStatus.swift
//  LMD
//
//  Created by Tahani on 05/03/1447 AH.
//

import Foundation
import SwiftUI

enum OrderStatusEnum: Int {
    case added = 1
    case confirmed = 2
    case canceled = 3
    case reassigned = 4
    case pickup = 5
    case start = 6
    case failed = 7
    case done = 8
    
    var statusImage: Image {
            switch self {
            case .done:
                return Image(systemName: "checkmark.circle") // ✅ Done
            default:
                return Image(systemName: "xmark.circle")    // ❌ Not Done
            }
        }
}

struct OrderAction: Identifiable, Equatable {
    
    let id = UUID()
    let title: String
    let nextStatus: OrderStatusEnum
    let alertTitle: String
    let alertMessage: String
}

func action(for statusID: Int) -> OrderAction? {
    
    guard let status = OrderStatusEnum(rawValue: statusID) else { return nil }
    
    switch status {
    case .added:
        return .init(title: "Confirm Order",
                     nextStatus: .confirmed,
                     alertTitle: "Confirm Pick Order",
                     alertMessage: "Are you sure?")
    case .confirmed:
        return .init(title: "Pick Order",
                     nextStatus: .pickup,
                     alertTitle: "Pick Order",
                     alertMessage: "Are you sure?")
    case .pickup:
        return .init(title: "Start Delivery",
                     nextStatus: .start,
                     alertTitle: "Start Delivery",
                     alertMessage: "Are you sure?")
    case .start:
        return .init(title: "Deliver Order",
                     nextStatus: .done,
                     alertTitle: "Deliver Order",
                     alertMessage: "Proceed to deliver?")
        
    case .canceled, .reassigned, .failed, .done:
        return nil
    }
}

