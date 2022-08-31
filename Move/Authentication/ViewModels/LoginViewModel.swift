//
//  LoginViewModel.swift
//  Move
//
//  Created by Raul Pele on 18.08.2022.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    let authenticationService: AuthenticationService
    
    var fieldsCompleted: Bool {
        return !email.isEmpty && !password.isEmpty
    }
    
    init(authenticationService: AuthenticationService) {
        self.authenticationService = authenticationService
    }
    
    func login(onLoginCompleted: @escaping () -> Void) {
        authenticationService.login(email: email, password: password, onLoginCompleted: onLoginCompleted)
    }
}
