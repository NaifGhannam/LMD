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
                            ForEach(viewModel.locations) { location in
                                Annotation("", coordinate: location.coordinates) {
                                    LocationMapAnnotationView(
                                        location: location,
                                        isSelected: viewModel.mapLocation == location
                                    ) {
                                        viewModel.showNextLocation(location: location)
                                    }
                                }
                            }
                        }
                    } else {
                        Map(coordinateRegion: $viewModel.region,
                            annotationItems: viewModel.locations
                        ) { location in
                            MapAnnotation(coordinate: location.coordinates) {
                                LocationMapAnnotationView(
                                    location: location,
                                    isSelected: viewModel.mapLocation == location
                                ) {
                                    viewModel.showNextLocation(location: location)
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
                            viewModel.showNextLocation(location: location)
                        } label: {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(location.customerName)
                                    .font(.headline)
                                Text("# \(location.orderNo)")
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
    }
}

#Preview {
    GeneralPoolView()
        .environmentObject(GeneralPoolViewModel())
}


