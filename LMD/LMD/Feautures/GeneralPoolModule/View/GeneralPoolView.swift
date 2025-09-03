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
                            ForEach(viewModel.orders, id: \.id) { order in
                                
                                Annotation("", coordinate: order.coordinate2D) {
                                    AnyView(
                                        LocationMapAnnotationView(
                                            location: order,
                                            isSelected: viewModel.mapOrder?.id == order.id
                                        ) {
                                            viewModel.showNextLocation(order: order)
                                        }
                                    )
                                }
                            }
                        }
                    } else {
                        Map(
                            coordinateRegion: $viewModel.region,
                            annotationItems: viewModel.orders
                        ) { order in

                            MapAnnotation(coordinate: order.coordinate2D) {
                                AnyView(
                                    LocationMapAnnotationView(
                                        location: order,
                                        isSelected: viewModel.mapOrder?.id == order.id
                                    ) {
                                        viewModel.showNextLocation(order: order)
                                    }
                                )
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
            
            testView(viewModel: viewModel)
        }
        .task {
            await viewModel.fetchOrders()
        }
    }
}

#Preview {
    GeneralPoolView()
        .environmentObject(GeneralPoolViewModel())
}


