//
//  LoginView.swift
//  Move
//
//  Created by Raul Pele on 18.08.2022.
//

import SwiftUI

struct LoginView: View {
    let errorHandler: ErrorHandler
    let authenticationService: AuthenticationService

    let onSignUpClicked: () -> Void
    let onLoginCompleted: () -> Void
    
    @StateObject private var loginViewModel: LoginViewModel
    
    init(errorHandler: ErrorHandler,
         authenticationService: AuthenticationService,
         onSignUpClicked: @escaping () -> Void,
         onLoginCompleted: @escaping () -> Void) {
        self.errorHandler = errorHandler
        self.authenticationService = authenticationService
        
        self.onLoginCompleted = onLoginCompleted
        self.onSignUpClicked = onSignUpClicked
        
        self._loginViewModel = StateObject(wrappedValue: LoginViewModel(authenticationService: authenticationService))
    }

    var body: some View {
        ZStack(alignment: .topLeading) {
            PurpleBackgroundView()
            
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
                        } onError: { error in
                            errorHandler.handle(error: error, title: "Login failed")
                        }
                        
                    } label: {
                        Text("Login")
                            .frame(maxWidth: .infinity)
                            .opacity(loginViewModel.isLoading ? 0 : 1)
                    }
                    .buttonStyle(.filledButton)
                    .disabled(loginViewModel.fieldsCompleted ? false : true)
                    .hasLoadingBehaviour(showLoadingIndicator: $loginViewModel.isLoading)
                    
                    createAccountFooterView
                    
                }
                .padding(.horizontal, 24)
                .padding(.vertical)
            }
        }
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
            LoginView(errorHandler: SwiftMessagesErrorHandler(), authenticationService: AuthenticationAPIService(sessionManager: .init()), onSignUpClicked: {}, onLoginCompleted: {})
            .previewDevice(device)
        }
    }
}

