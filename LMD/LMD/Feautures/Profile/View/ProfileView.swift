//
//  ProfileView.swift
//  LMD
//
//  Created by Naif on 25/02/1447 AH.
//
import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var loginViewModel: LoginViewModel
    @EnvironmentObject var languageManager: LanguageManager
    
    var body: some View {
        VStack(spacing: 10) {
            
        Text(NSLocalizedString("profile", comment: ""))
                .font(.largeTitle)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .background(Color.red)
            
            HStack {
                Image(systemName: "person.circle")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .padding()
                
                VStack(alignment: .leading, spacing: 10) {
                    if let user = loginViewModel.loggedInUser {
                        Text(user.fullName)
                            .font(.system(size: 20, weight: .bold))
                        Text(user.email)
                            .font(.callout)
                    } else {
                        Text("Guest")
                            .font(.system(size: 20, weight: .bold))
                        Text("Not logged in")
                            .font(.callout)
                    }
                }
                .padding(.horizontal, 20)
            }
            
            Rectangle()
                .frame(height: 2)
                .opacity(0.8)
                .padding(.horizontal, 40)
            
            VStack(spacing: 15) {
                settingsButton(image: "bell2", title:NSLocalizedString("notifications", comment: "") ) { }
                
                NavigationLink {
                    LanguageSelectionView()
                        .environmentObject(languageManager)
                } label: {
                    settingsButtonContent(image: "Language", title: NSLocalizedString("language", comment: ""))
                }
                
                settingsButton(image: "password2", title: NSLocalizedString("changePassword", comment: "")) { }
                settingsButton(image: "mdi_email", title: NSLocalizedString("chat", comment: "")) { }
            }
            
            Button {
                loginViewModel.logout()
            } label: {
                Text(NSLocalizedString("logout", comment: ""))
                    .frame(maxWidth: .infinity)
                    .frame(height: 53)
                    .font(.headline)
                    .foregroundColor(.white)
                    .background(Color.red)
                    .cornerRadius(10)
            }
            .padding(40)
            
            Spacer()
        }
    }
    
    private func settingsButtonContent(image: String, title: String) -> some View {
        HStack {
            Image(image)
                .foregroundColor(.black)
                .font(.system(size: 20, weight: .regular))
            Text(title)
                .foregroundColor(.black)
                .font(.system(size: 18, weight: .regular))
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.black)
                .font(.system(size: 20, weight: .regular))
        }
        .frame(height: 50)
        .padding(.horizontal)
    }
    
    private func settingsButton(image: String, title: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            settingsButtonContent(image: image, title: title)
        }
    }
}
