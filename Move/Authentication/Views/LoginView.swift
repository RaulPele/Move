//
//  LoginView.swift
//  Move
//
//  Created by Raul Pele on 18.08.2022.
//

import SwiftUI

struct LoginView: View {
    var errorHandler: ErrorHandler = MyErrorHandler.shared
    let onSignUpClicked: () -> Void
    let onLoginCompleted: () -> Void
    
    @StateObject private var loginViewModel = LoginViewModel()

    
    var body: some View {
        ZStack(alignment: .topLeading) {
            ScrollView {
                VStack(alignment: .leading, spacing: 32) {
                    AuthenticationHeaderView(logoPath: "SmallLogoWhite",
                                             title: "Login", description:
                                                "Enter your account credentials and start riding away")
                    
                    loginTextFieldsView
                    
                    Button {
                        
                    } label: {
                        Text("Forgot your password?")
                            .underline()
                            .font(.smallText())
                            .foregroundColor(.neutralWhite)
                    }
                    
                    Button {
//                        loginViewModel.isLoading = true
                        errorHandler.handle(error: APIError(message: "wrong email", code: 402), title: "Login failed")
//                        loginViewModel.login {
//                            onLoginCompleted()
//                            loginViewModel.isLoading = false
//                        }
                        
                    } label: {
                        Text("Login")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.filledButton)
                    .disabled(loginViewModel.fieldsCompleted ? false : true)
                    
                    createAccountFooterView
                    
                }
                .padding(.horizontal, 24)
                .padding(.vertical)
            }
        }
        .hasLoadingBehaviour(showLoadingIndicator: $loginViewModel.isLoading)
        .background(PurpleBackgroundView())

        
    }
}


private extension LoginView {
    var loginTextFieldsView: some View {
        return VStack(spacing: 26) {
            FloatingTextField(title: "Email address", text: $loginViewModel.email)
            FloatingSecureField(title: "Password", text: $loginViewModel.password)
        }
        .padding(.bottom, 3)
    }
    
    var createAccountFooterView: some View {
        HStack(spacing: 0) {
            Text("Don't have an account? You can")
                .foregroundColor(.neutralWhite)
                .font(.smallText())
            
            Button {
                onSignUpClicked()
            } label: {
                Text("start with one here")
                    .foregroundColor(.neutralWhite)
                    .underline()
                    .font(.smallText().bold())
                    .padding(.leading, 3)
                
            }
        }
        .padding(.horizontal, 19)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(devices) {device in
            LoginView(onSignUpClicked: {
                
            }, onLoginCompleted: {
                
            })
            .previewDevice(device)
        }
    }
}

