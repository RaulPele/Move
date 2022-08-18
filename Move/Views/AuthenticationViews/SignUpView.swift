//
//  SignUpView.swift
//  Move
//
//  Created by Raul Pele on 16.08.2022.
//

import SwiftUI

struct SignUpView: View {
    @StateObject var signUpViewModel: SignUpViewModel
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            PurpleBackgroundView()
            
            VStack(alignment: .leading, spacing: 32) {
                Image("SmallLogoWhite")
                    .renderingMode(.original)
                    .aspectRatio(contentMode: .fit)
                
                Text("Let's get started")
                    .font(.heading1())
                    .foregroundColor(.neutralWhite)
                
                Text("Sign up or login and start riding right away")
                    .font(.heading2())
                    .foregroundColor(.neutralGray)
                
                FloatingTextField(title: "Email address", text: $signUpViewModel.email)
                FloatingTextField(title: "Username", text: $signUpViewModel.username)
                FloatingTextField(title: "Password", text: $signUpViewModel.password, isSecured: true)
                
                Text("By continuing you agree to Move’s Terms and Conditions and Privacy Policy")
                    .foregroundColor(.neutralWhite)
                    .font(.smallText())
                
                Button() {
                    print("on get started click")
                } label: {
                    Text("Get started!")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.filledButton)
                .disabled(signUpViewModel.fieldsCompleted ? false : true)
                .animation(.default, value: signUpViewModel.fieldsCompleted)
                
                Text("You already have an account? You can log in here")
                    .foregroundColor(.neutralWhite)
                    .font(.smallText())
                    .padding(.horizontal, 35)
                
            }
            .padding(.horizontal, 24)
//            .frame(maxHeight: .infinity)
        
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(signUpViewModel: SignUpViewModel())
    }
}
