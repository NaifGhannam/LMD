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
    @State private var value: Double = 0
    private let container = AppContainer()
    
    var body: some View {
        VStack(spacing: 0) {
            PoolViewHeader()

            ZStack(alignment: .top) {
                Group {
                    if #available(iOS 17, *) {
                        Map(position: $viewModel.cameraPosition) {
                            UserAnnotation()
                            ForEach(viewModel.orders, id: \.id) { order in
                                Annotation("", coordinate: order.coordinate2D) {
                                    LocationMapAnnotationView(
                                        location: order,
                                        isSelected: viewModel.mapOrder?.id == order.id
                                    ) { viewModel.showNextLocation(order: order) }
                                }
                            }
                        }
                        .mapControls {
                            MapUserLocationButton()
                            MapCompass()
                        }
                    } else {
                        Map(coordinateRegion: $viewModel.region, annotationItems: viewModel.orders) { order in
                            MapAnnotation(coordinate: order.coordinate2D) {
                                LocationMapAnnotationView(
                                    location: order,
                                    isSelected: viewModel.mapOrder?.id == order.id
                                ) { viewModel.showNextLocation(order: order) }
                            }
                        }
                    }
                }

                VStack(spacing: 0) {
                    Text("\(value, specifier: "%.2f") Km").bold()
                    Slider(value: $value, in: 0...100)
                        .tint(Color("PrimaryRed"))
                        .onChange(of: value) { newValue, _ in viewModel.updateZoom(distanceKm: newValue) }
                }
                .foregroundColor(Color("PrimaryRed"))
                .padding(10)
                .frame(width: UIScreen.main.bounds.width * 0.7)
                .background(.white)
                .padding(.top)
            }

            testView(viewModel: viewModel, orderViewModel: container.makeMyOrdersVM())
        }
        .task {
            await viewModel.fetchOrders()
            await viewModel.start()
            viewModel.updateZoom(distanceKm: value)
        }
    }
}

#Preview {
    GeneralPoolView()
        .environmentObject(GeneralPoolViewModel())
}


