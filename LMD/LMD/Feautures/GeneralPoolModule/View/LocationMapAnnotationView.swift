//
//  LocationMapAnnotationView.swift
//  LMD
//
//  Created by Tahani on 29/02/1447 AH.
//

import SwiftUI

struct LocationMapAnnotationView: View {
    
    let location: Location
    let isSelected: Bool
    let onTap: (() -> ())?
    
    var body: some View {
        
        Image("MapMarker")
            .resizable()
            .scaledToFit()
            .frame(width: 35, height: 35)
            .scaleEffect(isSelected ? 1 : 0.7)
            .shadow(radius: 5)
            .onTapGesture { onTap?() }
    }
}
