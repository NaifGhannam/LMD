//
//  GeneralPoolView.swift
//  LMD
//
//  Created by Tahani on 25/02/1447 AH.
//

import SwiftUI
import MapKit

struct GeneralPoolView: View {
    @State private var searchText = ""
    @EnvironmentObject private var viewModel: GeneralPoolViewModel

    private var filteredLocations: [Location] {
        guard !searchText.isEmpty else { return viewModel.locations }
        return viewModel.locations.filter {
            $0.customerName.localizedCaseInsensitiveContains(searchText)
            || $0.orderNo.localizedCaseInsensitiveContains(searchText)
        }
    }

    var body: some View {
        
        NavigationStack {
            
            VStack(spacing: 0) {
                
                Text("My Pool")
                    .font(.system(size: 25, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color("PrimaryRed"))

                ZStack(alignment: .bottom) {
                    
                    Map(coordinateRegion: $viewModel.mapRegion, annotationItems: viewModel.locations, annotationContent: { location in
                        MapAnnotation(coordinate: location.coordinates) {
                            
                            Image("MapMarker")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 35, height: 35)
                                .scaleEffect(viewModel.mapLocation == location ? 1 : 0.7)
                                .shadow(radius: 5)
                                .onTapGesture {
                                    viewModel.showNextLocation(location: location)
                                }
                        }
                    })
                        .ignoresSafeArea()

                    VStack {
                        ScrollView(.horizontal) {
                            
                            HStack(spacing: 8) {
                                
                                ForEach(filteredLocations) { location in
                                    
                                    Button {
                                        
                                        viewModel.showNextLocation(location: location)
                                        
                                    } label: {
                                        HStack {
                                            
                                            VStack(alignment: .leading) {
                                                
                                                Text(location.customerName)
                                                    .font(.headline)
                                                
                                                Text("# \(location.orderNo)")
                                                    .font(.subheadline)
                                            }
                                            .foregroundColor(Color("PrimaryRed"))
                                        }
                                        .padding()
                                        .background(.white)
                                        .cornerRadius(12)
                                    }
                                }
                            }
                            .padding()
                        }
                    }
                    .background(Color("PrimaryRed"))

                }
            }
            .searchable(
                text: $searchText,
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: "Search by order NO or customer name"
            )
        }
    }
}

#Preview {
    GeneralPoolView()
        .environmentObject(GeneralPoolViewModel())
}
