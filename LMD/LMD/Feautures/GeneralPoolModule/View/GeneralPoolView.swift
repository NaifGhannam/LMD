//
//  GeneralPoolView.swift
//  LMD
//
//  Created by Tahani on 25/02/1447 AH.
//


import SwiftUI
import MapKit

struct GeneralPoolView: View {
    
    @EnvironmentObject private var viewModel: GeneralPoolViewModel
    @State private var value: Double = 100
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            PoolViewHeader()
            
            ZStack(alignment: .top) {
                
                Group {
                    if #available(iOS 17, *) {
                        Map(position: $viewModel.cameraPosition) {
                            ForEach(viewModel.orders, id: \.orderID) { location in
                                Annotation("", coordinate: location.coordinate2D) {
                                    LocationMapAnnotationView(
                                        location: location,
                                        isSelected: viewModel.mapOrder?.orderID == location.orderID
                                    ) {
                                        viewModel.showNextLocation(order: location)
                                    }
                                }
                            }
                        }
                    } else {
                        Map(coordinateRegion: $viewModel.region,
                            annotationItems: viewModel.orders
                        ) { location in
                            MapAnnotation(coordinate: location.coordinate2D) {
                                LocationMapAnnotationView(
                                    location: location,
                                    isSelected: viewModel.mapOrder?.orderID == location.orderID
                                ) {
                                    viewModel.showNextLocation(order: location)
                                }
                            }
                        }
                    }
                }
                
                VStack(spacing: 0) {
                    Text("\(value, specifier: "%.2f") Km")
                        .bold()
                    
                    Slider(value: $value, in: 0...100)
                        .tint(Color("PrimaryRed"))
                }
                .foregroundColor(Color("PrimaryRed"))
                .padding(10)
                .frame(width: UIScreen.main.bounds.width * 0.7)
                .background(.white)
                .padding(.top)
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(viewModel.filteredLocations()) { location in
                        Button {
                            viewModel.showNextLocation(order: location)
                        } label: {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(location.customerName)
                                    .font(.headline)
                                Text("# \(location.orderNumber)")
                                    .font(.subheadline)
                            }
                            .foregroundColor(Color("PrimaryRed"))
                            .padding()
                            .frame(width: 260, alignment: .leading)
                            .background(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 14)
            }
        }
        .background(Color("PrimaryRed"))
        .task {
            await viewModel.fetchOrders()
        }
    }
}

#Preview {
    GeneralPoolView()
        .environmentObject(GeneralPoolViewModel())
}


