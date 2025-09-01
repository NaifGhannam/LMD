//
//  Orders-On-General-Pool.swift
//  LMD
//
//  Created by Naif on 25/02/1447 AH.
//

import SwiftUI

struct Orders_On_General_Pool_Card : View {
    @State var name : String
    @State var orderID : String
    @State var CreatedAt : String
    @State var  numberOfOrders  : Int?
    @State var RoadDistance : Double?
    
    private var createdDate: Date? {
           let formatter = ISO8601DateFormatter()
           formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
           return formatter.date(from: CreatedAt)
       }
       
       private var timeAgo: String {
           guard let date = createdDate else { return "unknown time" }
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
                     VStack (spacing : 10){
                         
                         Image(systemName: "location.circle.fill")
                             .resizable()
                             .frame(width: 20, height: 20)
                           .foregroundColor(.white)
                            
                             //ADD spacing from API
                         Text("\(RoadDistance ?? 0, specifier: "%.2f") km")
                             .fontWidth(.condensed)
                             .foregroundColor(.white)
                             
                     }
                     .padding()
                     .background(.red)
                     .clipShape(Circle())
                     .padding(.leading , 6)
                       
                     VStack(alignment : .leading, spacing: 3){
                           Text("\(name)")
                             .font(.headline)
                               .fontWeight(.bold)
                               .foregroundStyle(.red)
                           
                         Text("#\(orderID)")
                             .font(.callout)
                               .fontWeight(.regular)
                               .foregroundStyle(.secondary)
                         Text("ordered \(timeAgo)")
                                                       .font(.callout)
                                                       .fontWeight(.regular)
                                                       .foregroundStyle(.secondary)

                           Text("items in order (\(numberOfOrders))")
                             .font(.caption)
                               .fontWeight(.regular)
                               .foregroundStyle(.secondary)
                           
                       }.padding(.leading , 5)
                     Spacer()
                       
                 }
                 .padding(1)
                   .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height * 0.11)
                   
                   .background(Color.white)
                   .padding()
             }//.padding(.horizontal , 10)
                    
            }
            .frame(maxWidth: .infinity , maxHeight: UIScreen.main.bounds.height * 0.12)
            
        }
        
    }
}

#Preview {
    Orders_On_General_Pool_Card(
        name: "Hanan",
        orderID: "181818",
        CreatedAt: "25/02/1447 AH",
        numberOfOrders: 3,
        RoadDistance: 12.5
    )
}
