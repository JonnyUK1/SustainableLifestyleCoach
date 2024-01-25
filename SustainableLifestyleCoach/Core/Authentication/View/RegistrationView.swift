//
//  RegistrationView.swift
//  SustainableLifestyleCoach
//
//  Created by Jonny Walker on 23/01/2024.
//

//TODO: Add comments throughout

import SwiftUI

struct RegistrationView: View {
    
    @State private var email = ""
    @State private var fullName = ""
    @State private var password = ""
    @State private var confirmPassword = ""    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        
        VStack {
            Image(systemName: "lock.fill")
                .resizable()
                .scaledToFill()
                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 120)
                .padding(.vertical, 32)
            
            VStack(spacing: 24) {
                InputView(text: $email, 
                          title: "Email Address",
                          placeholder: "name@example.com")
                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                
                InputView(text: $fullName,
                          title: "Full name",
                          placeholder: "Enter your name")
                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                
                InputView(text: $password, 
                          title: "Password:",
                          placeholder: "Enter your password")
                
                ZStack(alignment: .trailing) {
                    InputView(text: $confirmPassword,
                              title: "Confirm Password",
                              placeholder: "Confirm your password")
                    
                    if !password.isEmpty && !confirmPassword.isEmpty {
                        if password == confirmPassword {
                            Image(systemName: "checkmark.circle.fill")
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundColor(Color(.systemGreen))
                        } else {
                            Image(systemName: "xmark.circle.fill")
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundColor(Color(.systemRed))
                        }
                    }
                }
            }
        }
        
        .padding(.horizontal)
        .padding(.top, 12)
        
        Button {
            Task {
                try await viewModel.createUser(withEmail: email,
                                               password: password,
                                               fullName: fullName)
            }
        } label: {
            HStack{
                Text("SIGN UP")
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                Image(systemName: "arrow.right")
            }
            .foregroundColor(.white)
            .frame(width: UIScreen.main.bounds.width - 32, height: 48 )
        }
        .background(Color(.systemBlue))
        .disabled(!formIsValid)
        .opacity(formIsValid ? 1.0 : 0.5)
        .cornerRadius(15)
        .padding(.top, 24)
        
        Spacer()
        
        Button{
            dismiss()
        }
    label: {
        HStack {
            Text ("Already Have an account?")
            Text ("Sign in")
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
        }
        .font(.system(size: 14))
    }
        
        
    }
}

extension RegistrationView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
        && confirmPassword == password
        && !fullName.isEmpty
    }
}


#Preview {
    RegistrationView()
        .environmentObject(AuthViewModel())
    
}

