//
//  LoginView.swift
//  Move
//
//  Created by Raul Pele on 18.08.2022.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var loginViewModel: LoginViewModel
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            PurpleBackgroundView()
            
            VStack(alignment: .leading, spacing: 32) {
                VStack(alignment: .leading, spacing: 20) {
                    Image("SmallLogoWhite")
                        .renderingMode(.original)
                        .aspectRatio(contentMode: .fit)
                        .padding(.bottom, 4)
                    
                    Text("Login")
                        .font(.heading1())
                        .foregroundColor(.neutralWhite)
                    
                    Text("Enter your account credentials and start riding away")
                        .font(.heading2())
                        .foregroundColor(.neutralGray)
                }
                
                VStack(spacing: 26) {
                    FloatingTextField(title: "Email address", text: $loginViewModel.email)
                    FloatingSecureField(title: "Password", text: $loginViewModel.password)
                }
                .padding(.bottom, 3)
                
                Button {
                    
                } label: {
                    Text("Forgot your password?")
                        .underline()
                        .font(.smallText())
                        .foregroundColor(.neutralWhite)
                }
                
                Button{
                    
                } label: {
                    Text("Login")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.filledButton)
                .disabled(loginViewModel.fieldsCompleted ? false : true)
                
                HStack(spacing: 0) {
                    Text("Don't have an account? You can ")
                        .foregroundColor(.neutralWhite)
                        .font(.smallText())
                    
                    Button {
                        
                    } label: {
                        Text("start with one here")
                            .foregroundColor(.neutralWhite)
                            .underline()
                            .font(.smallText().bold())
                        
                    }
                }
                .padding(.horizontal, 19)
            }
            .padding(.horizontal, 24)
            .padding(.vertical)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(loginViewModel: .init())
            .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro"))
            .previewDisplayName("iPhone 13 Pro")
            
        LoginView(loginViewModel: .init())
            .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
            .previewDisplayName("iPhone 8")
    }
}
    
