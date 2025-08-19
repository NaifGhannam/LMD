//
//  testView.swift
//  LMD
//
//  Created by Naif on 25/02/1447 AH.
//

import SwiftUI

struct testView: View {
    var body: some View {
        VStack{
           Text("Hello, World!")
                .font(.largeTitle)
                .foregroundColor(.blue)
                .padding()
                .background(Color.yellow)
                .cornerRadius(20)
                .shadow(radius: 10)
                .padding()
            
            Text("Hello, World!")
                .frame(width: 300, height: 200, alignment: .center)

            ScrollView (.horizontal){
                HStack (spacing : 0){
                    ForEach(1...10 ,id : \.self){_ in
                        Orders_On_General_Pool_Card(name: "ahmad", orderID: "20000", CreatedAt: Date() , numberOfOrders: 1, RoadDistance: 19)
                        
                    }
                }
            }
        }
    }
}

#Preview {
    testView()
}
