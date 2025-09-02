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
    @State var time : String = "منذ 2 ساعات و 30 دقيق"
    
    
    var body: some View {
        
        VStack (alignment : .leading){
            HStack{
                Spacer()
                
                Text("\(price.isFinite ? String(format: "%.1f", price) : "0") $")
                    .padding(.trailing, 10)

            }
            HStack{
                
                
                VStack(alignment: .leading){
                    
                    
                    
                    Text("\(Number)")
                        .foregroundStyle(.secondary)
                    Text("\(name)")
                    
                    Text("\(time)")
                        .foregroundStyle(.secondary)

                    
                    
                }
                .padding(.leading ,7)
                Spacer()
                
            }
        }
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .overlay(
            Rectangle()
                .stroke(style: StrokeStyle(lineWidth: 1))
                .foregroundColor(Color.black.opacity(0.2))
                .shadow(color: Color.black, radius: 10, x: 5, y: 0)
            )
        
            .padding(6)
    }
}

#Preview {
    OrderHistoryCard()
}
