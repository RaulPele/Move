//
//  AuthenticationCoordinatorView.swift
//  Move
//
//  Created by Raul Pele on 17.08.2022.
//

import SwiftUI

enum AuthenticationCoordinatorState {
    case signUp
}

struct AuthenticationCoordinatorView: View {
    @State var state: AuthenticationCoordinatorState? = .signUp
    
    var body: some View {
        NavigationView {
            ZStack {
                NavigationLink(tag: .signUp, selection: $state) {
                    SignUpView(signUpViewModel: SignUpViewModel())
                        .navigationBarHidden(true)
                } label: {
                    EmptyView()
                }
            }
        }
    }
}

struct AuthenticationCoordinatorView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationCoordinatorView()
    }
}
