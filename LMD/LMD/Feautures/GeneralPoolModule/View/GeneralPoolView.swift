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
        let text = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !text.isEmpty else { return viewModel.locations }
        return viewModel.locations.filter {
            $0.customerName.localizedCaseInsensitiveContains(text)
            || $0.orderNo.localizedCaseInsensitiveContains(text)
        }
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {

                // Header with title + search field
                VStack(alignment: .leading, spacing: 12) {
                    Text("My Pool")
                        .font(.system(size: 25, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .center)

                    HStack(spacing: 8) {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)

                        TextField("Search by order NO or customer name", text: $searchText)
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled()
                            .foregroundColor(Color.black)
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 10)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .stroke(.white.opacity(0.25), lineWidth: 1)
                    )
                }
                .padding(.horizontal)
                .padding(.top, 8)
                .padding(.bottom, 12)
                .background(Color("PrimaryRed"))

                ZStack(alignment: .bottom) {
                    Map(
                        coordinateRegion: $viewModel.mapRegion,
                        annotationItems: viewModel.locations
                    ) { location in
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
                    }
                    .ignoresSafeArea(edges: .bottom) // keep header visible

                    // Bottom horizontal cards
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            ForEach(filteredLocations) { location in
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
                    .background(Color("PrimaryRed"))
                }
            }
            // removed `.searchable` so it doesn’t jump to the nav bar
        }
    }
}

#Preview {
    GeneralPoolView()
        .environmentObject(GeneralPoolViewModel())
}
