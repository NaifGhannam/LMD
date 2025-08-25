//
//  DeliveryLogView.swift
//  LMD
//
//  Created by Tahani on 02/03/1447 AH.
//

import SwiftUI

struct DeliveryLogView: View {
    var body: some View {
        VStack {
            
            HStack {
               Text("Delivery Log")
                    .font(.system(size: 20, weight: .bold))
                
                Spacer()
                
                Button(action: {}) {
                    Image(systemName: "magnifyingglass")
                }
                
            }
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color("PrimaryRed"))
            
            VStack {
              
                HStack {
                    
                    Text("SLA")

                    
                    Text("Order details")
                        .font(.system(size: 18))
                    .padding(.horizontal, 14)
                    
                    Spacer()
                    
                    Text("Delivery time")
                }
                .foregroundColor(.gray)
                
                ForEach(1...3, id: \.self) { index in
                    HStack {
                        
                        Image(systemName: "checkmark.circle")
                            .resizable()
                            .frame(width: 26, height: 26)
                            .foregroundColor(Color("PrimaryGreen"))

                        
                        VStack {
                            Text("15/9/2019 3:00pm")
                                .font(.system(size: 18))
                            
                            Text("#234526262234")
                                .foregroundColor(.gray)
                        }
                        .padding(.horizontal, 14)
                        
                        Spacer()
                        
                        Text("30 mins ago")
                            .foregroundColor(Color("PrimaryGreen"))
                            .bold()
                    }
                    .padding(.vertical)
                }
            }
            .padding(20)
            
            Spacer()
        }
    }
}

#Preview {
    DeliveryLogView()
}
