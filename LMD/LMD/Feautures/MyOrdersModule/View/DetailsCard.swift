//
//  DetailsCard.swift
//  LMD
//
//  Created by Tahani on 25/02/1447 AH.
//

import SwiftUI

struct DetailsCard: View {
    
    let order: Order = Order(orderId: 1, orderNumber: "# 181818", orderDate: "10/10/2025", status: OrderStatus(name: "confirmed", colorCode: "PrimaryGreen"), customerName: "Hanan", address: "King Fahd St 123")
    
    var body: some View {
        VStack {
            HStack {
                
                VStack(spacing: 7) {
                    Image(systemName: "location.north.fill")
                    
                    Text("17.00")
                }
                .foregroundColor(.white)
                .padding()
                .background(Color("PrimaryRed"))
                .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: 0) {
                    
                    Text("# 181818")
                        .foregroundColor(.gray.opacity(0.7))
                        .bold()
                    
                    Text("Hanan")
                    
                    Text("new")
                        .foregroundColor(Color("PrimaryRed"))
                }
                
                Spacer()
                
                VStack {
                    Text("confirmed")
                        .foregroundColor(Color("PrimaryGreen"))
                        .bold()
                    
                    Spacer()
                        .frame(height: 20)
                    
                    HStack(spacing: 1) {
                        Text("100.0")
                            .font(.system(size: 22, weight: .bold))
                        Text("LE")
                            .foregroundColor(.gray)
                    }
                }
            }
            
            HStack {
                
                CustomButton(title: "Order Details")
                    
                CustomButton(title: "Pick Order")
            }
            .padding(.bottom)
            
            CustomButton(showIcon: true, title: "Call")
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.white)
        .cornerRadius(5)
        .shadow(radius: 3)
    }
}

#Preview {
    DetailsCard()
}
