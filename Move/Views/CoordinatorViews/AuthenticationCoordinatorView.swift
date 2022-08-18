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
    
    var body: some View {
        NavigationView {
            ZStack {
                NavigationLink(tag: .signUp, selection: $state) {
                    SignUpView(signUpViewModel: .init()) {
                        state = .login
                    }
                    .transition(.opacity.animation(.default))

                    .navigationBarHidden(true)
                    
                } label: {
                    EmptyView()
                }
                
                NavigationLink(tag: .login, selection: $state) {
                    LoginView(loginViewModel: LoginViewModel()) {
                        state = .signUp
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
            AuthenticationCoordinatorView()
                .previewDevice(device)
            
        }
    }
}
