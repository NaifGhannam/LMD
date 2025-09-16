//
//  LoginView.swift
//  LMD
//
//  Created by Naif on 24/02/1447 AH.
//
import SwiftUI

struct LoginView: View {
    @EnvironmentObject var viewModel: LoginViewModel
    @EnvironmentObject var languageManager: LanguageManager

    
    var body: some View {
        VStack(spacing: 20) {
            
            Image("NTG_logo")
                .resizable()
                .scaledToFit()
                .frame(width: 250, height: 300)
                .padding(.bottom)
            
            // Email
            HStack {
                TextField(NSLocalizedString("email", comment: ""), text: $viewModel.email)
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
                SecureField(NSLocalizedString("password", comment :""), text: $viewModel.password)
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
                Text(NSLocalizedString("login", comment: ""))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .background(Color.red)
                    .cornerRadius(10)
                    .padding(.horizontal, 50)
                    .padding(.top, 40)
            }
            
            if let error = viewModel.errorMessage {
                Text(error).foregroundColor(.red)
            }

            Spacer()
        }
        .padding()
        .navigationTitle("")
        .toolbar {
                   ToolbarItem(placement: .navigationBarTrailing) {
                       Menu {
                           ForEach(AppLanguage.allCases, id: \.self) { lang in
                               Button {
                                   languageManager.setLanguage(lang)
                               } label: {
                                   HStack {
                                       Text(NSLocalizedString("language_\(lang.rawValue)", comment: ""))
                                       Spacer()
                                       if languageManager.currentLanguage == lang {
                                           Image(systemName: "checkmark")
                                               .foregroundColor(.red)
                                       }
                                   }
                               }
                           }
                       } label: {
                           Image(systemName: "globe")
                               .foregroundColor(.red)
                       }
                   }
               }
           }
       }

#Preview {
    NavigationStack {
        LoginView()
            .environmentObject(LoginViewModel())
            .environmentObject(LanguageManager())
    }
}
