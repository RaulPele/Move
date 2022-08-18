//
//  SignUpView.swift
//  Move
//
//  Created by Raul Pele on 16.08.2022.
//

import SwiftUI

struct SignUpView: View {
    @ObservedObject var signUpViewModel: SignUpViewModel
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            PurpleBackgroundView()
            
            VStack(alignment: .leading, spacing: 32) {
                
                VStack(alignment: .leading, spacing: 20) {
                    Image("SmallLogoWhite")
                        .renderingMode(.original)
                        .aspectRatio(contentMode: .fit)
                        .padding(.bottom, 4)
                    
                    Text("Let's get started")
                        .font(.heading1())
                        .foregroundColor(.neutralWhite)
                    
                    Text("Sign up or login and start riding right away")
                        .font(.heading2())
                        .foregroundColor(.neutralGray)
                }
                
                VStack(spacing: 26) {
                    FloatingTextField(title: "Email address", text: $signUpViewModel.email)
                    FloatingTextField(title: "Username", text: $signUpViewModel.username)
                    FloatingSecureField(title: "Password", text: $signUpViewModel.password)
                }
                .padding(.bottom, 3)
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("By continuing you agree to Move's ")
                        .font(.smallText())
                        .foregroundColor(.neutralWhite)
                    
                    HStack(spacing: 0) {
                        Text("[Terms and Conditions](https://tapptitude.com)")
                            .underline()
                            .font(.smallText().bold())
                            .accentColor(.neutralWhite)
                    
                        Text(" and ")
                            .foregroundColor(.neutralWhite)
                            .font(.smallText())
                        
                        Text("[Privacy Policy](https://tapptitude.com)")
                            .underline()
                            .accentColor(.neutralWhite)
                            .font(.smallText().bold())
                    }
                        
                }
                
                Button() {
                    print("on get started click")
                } label: {
                    Text("Get started!")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.filledButton)
                .disabled(signUpViewModel.fieldsCompleted ? false : true)
                .animation(.default, value: signUpViewModel.fieldsCompleted)
                
                
                HStack(spacing: 0) {
                    Text("You already have an account? You can ")
                        .foregroundColor(.neutralWhite)
                        .font(.smallText())
                    
                    Button {
                        
                    } label: {
                        Text("log in here")
                            .foregroundColor(.neutralWhite)
                            .underline()
                            .font(.smallText().bold())
                        
                    }
                }
                .padding(.horizontal, 25) //35
            }
            .padding(.horizontal, 24)
            .padding(.vertical)
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(signUpViewModel: SignUpViewModel())
    }
}
