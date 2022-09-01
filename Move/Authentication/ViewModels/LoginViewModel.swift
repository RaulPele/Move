//
//  LoginViewModel.swift
//  Move
//
//  Created by Raul Pele on 18.08.2022.
//

import Foundation

extension LoginView {
    class LoginViewModel: ObservableObject {
        @Published var email: String = ""
        @Published var password: String = ""
        private let authenticationService: AuthenticationService = AuthenticationAPIService()
        
        var fieldsCompleted: Bool {
            return !email.isEmpty && !password.isEmpty
        }
        
        func login(onLoginCompleted: @escaping () -> Void) {
            authenticationService.login(email: email, password: password, onLoginCompleted: onLoginCompleted)
        }
    }
}
