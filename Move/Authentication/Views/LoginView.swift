//
//  LoginView.swift
//  Move
//
//  Created by Raul Pele on 18.08.2022.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var loginViewModel = LoginViewModel()
    let onSignUpClicked: () -> Void
    let onLoginCompleted: () -> Void
    
    var body: some View {
//        ZStack(alignment: .topLeading) {
//            PurpleBackgroundView()
            
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
                        loginViewModel.isLoading = true
                        
                        loginViewModel.login {
                            onLoginCompleted()
                            loginViewModel.isLoading = false
                        }
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
            .hasLoadingBehaviour(showLoadingIndicator: $loginViewModel.isLoading)
            .background(PurpleBackgroundView())
//        }
        
    }
}

struct LoadingBehaviour: ViewModifier {
    @Binding var showLoadingIndicator: Bool
    
    func body(content: Content) -> some View {
        if showLoadingIndicator {
            return AnyView(content
                .disabled(true)
                .blur(radius: 1.5)
                .overlay(ActivityIndicator(isVisible: $showLoadingIndicator, color: .white).frame(width: 100, height: 100)))
        } else {
            return AnyView(content)
        }
    }
}

extension View {
    func hasLoadingBehaviour(showLoadingIndicator: Binding<Bool>) -> some View {
        modifier(LoadingBehaviour(showLoadingIndicator: showLoadingIndicator))
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

