//
//  Orders-On-General-Pool.swift
//  LMD
//
//  Created by Naif on 25/02/1447 AH.
//

import SwiftUI

struct Orders_On_General_Pool_Card : View {
    @State var name : String = "Hanan"
    @State var orderID : String = "181818"
    @State var CreatedAt : Date  = Date()
    @State var  numberOfOrders : Int = 0
    @State var RoadDistance : Int = 18
    
    var body: some View {
        VStack {
            ZStack {
                Color.red
                
             VStack {
                 HStack{
                     Rectangle()
                           .fill(Color.red)
                           .frame(width: 100, height: 100)
                           .cornerRadius(50)
                           .overlay(
                            VStack (spacing : 20){
                                
                                Image(systemName: "location.circle.fill")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                  .foregroundColor(.white)
                                   
                                    //ADD spacing from API
                                Text("\(RoadDistance) km")
                                    .scaledToFit()
                                    .foregroundColor(.white)
                                   
                                    
                            }
                            )
                           .padding(.leading)
                           
                       
                     VStack(alignment : .leading){
                           Text("\(name)")
                               .font(.title2)
                               .fontWeight(.bold)
                               .foregroundStyle(.red)
                           
                         Text("#\(orderID) orderd at \(CreatedAt.description.split(separator: " ")[0]) \(CreatedAt.description.split(separator: " ")[1])")
                               .font(.title2)
                               .fontWeight(.regular)
                               .foregroundStyle(.secondary)
                           Text("items in order (\(numberOfOrders))")
                               .font(.title2)
                               .fontWeight(.regular)
                               .foregroundStyle(.secondary)
                           
                       }.padding(.leading , 30)
                     Spacer()
                       
                 }
                   .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height * 0.2)
                   .background(Color.white)
                 
             }.padding(.horizontal , 10)
                    
            }
            .frame(maxWidth: .infinity , maxHeight: 250)
            Spacer()
        }
        
    }
}

#Preview {
    Orders_On_General_Pool_Card()
}
