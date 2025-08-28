//
//  LoginView.swift
//  LMD
//
//  Created by Naif on 24/02/1447 AH.
//
import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            
            Image("NTG_logo")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 250)
                .padding(.bottom)
            
            // Email
            HStack {
                TextField("Email", text: $viewModel.email)
                Image(systemName: "person.fill")
                    .foregroundColor(.red)
            }
            .padding()
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.red, lineWidth: 2)
            }
            
            // Password
            HStack {
                SecureField("Password", text: $viewModel.password)
                Image(systemName: "key.fill")
                    .foregroundColor(.red)
            }
            .padding()
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.red, lineWidth: 2)
            }
            
            if viewModel.isLoading {
                ProgressView()
            }
            
            Button {
                Task { await viewModel.login() }
            } label: {
                Text("Login")
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .background(Color.red)
                    .cornerRadius(10)
                    .padding(.horizontal, 50)
                    .padding(.top, 40)
            }
            
            if let error = viewModel.errorMessage {
                Text(error).foregroundColor(.red)
            }
            // Display logged in user info
            if let user = viewModel.loggedInUser?.user {
                VStack(spacing: 5) {
                    Text("Logged in as:")
                        .font(.headline)
                    Text(user.fullName)
                        .font(.subheadline)
                }
                .padding(.top)
            }
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    LoginView()
}
