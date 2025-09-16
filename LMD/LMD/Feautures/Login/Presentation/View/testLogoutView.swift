//
//  testLogoutView.swift
//  LMD
//
//  Created by Naif on 09/03/1447 AH.
//

import SwiftUI

struct testLogoutView: View {
    @StateObject private var viewModel = LoginViewModel()

    var body: some View {
        Button{
            Task {
                try? await viewModel.logout()
            }
           // viewModel.logout()
        } label: {
            Text("Logout")
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .background(Color.red)
                .cornerRadius(10)
        }
    }
}

#Preview {
    testLogoutView()
}
