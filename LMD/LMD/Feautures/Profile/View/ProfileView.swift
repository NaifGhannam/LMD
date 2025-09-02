//
//  ProfileView.swift
//  LMD
//
//  Created by Naif on 25/02/1447 AH.
//

import SwiftUI

struct ProfileView: View {
    @StateObject private var viewModel = LoginViewModel()
//    @State var name : String = "naif almutairi"
//    @State var email : String = "naif@gmail.com"
    var body: some View {
        VStack (spacing:10){
            
            Text("Profile")
                .font(.largeTitle)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity )
                .background(Color.red)
                
            
            HStack(){
                Image(systemName :"person.circle")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .padding()
                
                
                VStack(alignment: .leading , spacing: 10 ){
                    if let user = viewModel.loggedInUser {
                        Text("\(user.fullName)")
                            .font(.system(size: 20, weight: .bold ))
                        Text("\(user.email)")
                            .font(.callout)
                    }else {
                        Text("Guest")
                            .font(.system(size: 20, weight: .bold ))
                        Text("Not logged in")
                            .font(.callout)
                    }
                 
                    
                }.padding(.horizontal , 20)
            }
            Rectangle()
                .frame(height: 2)
                .opacity(0.8)
                .padding(.horizontal , 40)
            
            //buttons
            VStack(spacing: 15) {
                settingsButton(image: "bell2", title: "notifications") {
                    print("Notifications tapped")
                }
                
                    settingsButton(image: "Language", title: "language"){
                        print("Language tapped")

                    }
                    
                
                
                settingsButton(image: "password2", title: "changePassword") {
                    print("Change password tapped")
                }
                settingsButton(image:"mdi_email", title: "chat"){
                    
                }
                
            }
            
            Button {
//                logoutViewModel.logout()
                print("log out")
            } label: {
                Text("log out")
                    .frame(maxWidth: .infinity)
                    .frame(height: 53)
                    .font(.headline)
                    .foregroundColor(.white)
                    .background(Color.red)
                    .cornerRadius(10)
            }
            .padding(90)
            
            Spacer()
        }
        
    }
    
    // MARK: - Helper Views
    @ViewBuilder
    private func settingsButton(image: String, title: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack {
                Image(image)
                    .foregroundStyle(.black)
                    .font(.system(size: 20, weight: .regular))
                Text(title)
                    .foregroundStyle(.black)
                    .font(.system(size: 18, weight: .regular))
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundStyle(.black)
                    .font(.system(size: 20, weight: .regular))
            }
            .frame(height: 50)
            .padding(.horizontal)
        }
    }

}

#Preview {
    ProfileView()
}
