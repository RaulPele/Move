//
//  SignUpView.swift
//  Move
//
//  Created by Raul Pele on 16.08.2022.
//

import SwiftUI

struct SignUpView: View {
    @StateObject private var signUpViewModel = SignUpViewModel()
    let onLoginClicked: () -> Void
    let onRegisterCompleted: () -> Void
    
    var body: some View {
//        ZStack(alignment: .topLeading) {
//            PurpleBackgroundView()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 32) {
                    AuthenticationHeaderView(logoPath: "SmallLogoWhite",
                                             title: "Let's get started",
                                             description: "Sign up or login and start riding right away")
                    
                    signUpTextFieldsView
                    termsAndConditionsView
                    
                    Button() {
                        signUpViewModel.register {
                            onRegisterCompleted()
                        }
                    } label: {
                        Text("Get started!")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.filledButton)
                    .disabled(signUpViewModel.fieldsCompleted ? false : true)
                    .animation(.default, value: signUpViewModel.fieldsCompleted)
                    
                    loginFooterView
                }
                .padding(.horizontal, 24)
                .padding(.vertical)
            }
            .background(PurpleBackgroundView())
//        }
    }
}

private extension SignUpView {
    var signUpTextFieldsView: some View {
        return VStack(spacing: 26) {
            FloatingTextField(title: "Email address", text: $signUpViewModel.email)
            FloatingTextField(title: "Username", text: $signUpViewModel.username)
            FloatingSecureField(title: "Password", text: $signUpViewModel.password)
        }
        .padding(.bottom, 3)
    }
    
    var termsAndConditionsView: some View {
        return VStack(alignment: .leading, spacing: 0) {
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
    }
    
    var loginFooterView: some View {
        return HStack(spacing: 0) {
            Text("You already have an account? You can ")
                .foregroundColor(.neutralWhite)
                .font(.smallText())
            
            Button {
                onLoginClicked()
            } label: {
                Text("log in here")
                    .foregroundColor(.neutralWhite)
                    .underline()
                    .font(.smallText().bold())
                
            }
        }
        .padding(.horizontal, 25) //35
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(devices) { device in
            SignUpView {} onRegisterCompleted: {
                
            }
                .previewDevice(device)
                .previewDisplayName(device.id)
        }
    }
}
