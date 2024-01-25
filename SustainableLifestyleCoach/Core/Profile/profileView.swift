//
//  profileView.swift
//  SustainableLifestyleCoach
//
//  Created by Jonny Walker on 23/01/2024.
//

//TODO: Update signout so that when the user signs out they are redirected to the login page
//TODO: Add comments throughout

import SwiftUI

struct profileView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var isLoggedOut = false // New state to track if the user is logged out
    
    var body: some View {
        if let user = viewModel.currentUser {
            List {
                Section {
                    HStack {
                        Text(user.initials)
                            .font(.title)
                            .fontWeight(.semibold)
                            .frame(width: 72, height:72)
                            .background(Color(.systemGray))
                            .clipShape(Circle())
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(user.fullName)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .padding(.top, 4)
                            
                            Text(user.email)
                                .font(.footnote)
                                .accentColor(.gray)
                        }
                        
                    }
                }
                
                Section("General") {
                    HStack {
                        SettingsRowView(imageName: "gear",
                                        title: "Version",
                                        tintColor: Color(.systemGray))
                        
                        Spacer()
                        
                        Text("1.0.0")
                            .font(.subheadline)
                            .accentColor(.gray)
                    }
                    
                }
                
                Section("Account") {
                    Button {
                        viewModel.signOut()
                        //viewModel.signOut()
                        
                        
                    } label: {
                        SettingsRowView(imageName: "arrow.left.circle.fill",
                                        title: "Sign Out",
                                        tintColor: .red)
                        
                    }
                    
                    Button {
                        viewModel.deleteAccount()
                    } label: {
                        SettingsRowView(imageName: "xmark.circle.fill",
                                        title: "Delete Account",
                                        tintColor: .red)
                    }
                }
            }
        }
    }
}


struct profileView_Previews: PreviewProvider {
    static var previews: some View {
        profileView()
            .environmentObject(AuthViewModel())
        
    }
}

