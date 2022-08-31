//
//  AuthenticationCoordinatorView.swift
//  Move
//
//  Created by Raul Pele on 17.08.2022.
//

import SwiftUI

enum AuthenticationCoordinatorState {
    case signUp
    case login
}

struct AuthenticationCoordinatorView: View {
    @State var state: AuthenticationCoordinatorState? = .signUp
    let onLoginCompleted: () -> Void
    let onRegisterCompleted: () -> Void
    
    var body: some View {
        NavigationView {
            ZStack {
                NavigationLink(tag: .signUp, selection: $state) {
                    SignUpView(signUpViewModel: .init(authenticationService: AuthenticationAPIService(url: "https://move-scooters.herokuapp.com/users/register")), onLoginClicked: {
                            state = .login
                    }, onRegisterCompleted: {
                        onRegisterCompleted()
                    })
                    .transition(.opacity.animation(.default))

                    .navigationBarHidden(true)
                    
                } label: {
                    EmptyView()
                }
                
                NavigationLink(tag: .login, selection: $state) {
                    LoginView(loginViewModel: LoginViewModel(authenticationService: AuthenticationAPIService(url: "https://move-scooters.herokuapp.com/users/login"))) {
                        state = .signUp
                    } onLoginCompleted: {
                        onLoginCompleted()
                    }
                    .navigationBarHidden(true)
                    .transition(.opacity.animation(.default))
                    
                } label: {
                    EmptyView()
                }
            }
        }
        .preferredColorScheme(.dark)
    }
}

struct AuthenticationCoordinatorView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(devices) { device in
            AuthenticationCoordinatorView(onLoginCompleted: {}, onRegisterCompleted: {})
                .previewDevice(device)
            
        }
    }
}
