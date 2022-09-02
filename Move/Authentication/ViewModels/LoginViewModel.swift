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
        @Published var isLoading = false
        
        private let authenticationService: AuthenticationService = AuthenticationAPIService()
        
        var fieldsCompleted: Bool {
            return !email.isEmpty && !password.isEmpty
        }
        
        func login(completionHandler: @escaping (Result<User, Error>) -> Void) {
            authenticationService.login(email: email, password: password, completionHandler: completionHandler)
        }
        
//        func handle(result: Result<User, Error>, onLoginCompleted: () -> Void) {
//            switch result {
//            case .success(_):
//                onLoginCompleted()
//            case .failure(let error):
//                errorHandler.handle(error: error, title: "Login failed")
//                print("Login failed error. Failure case.")
//            }
//        }
    }
}
