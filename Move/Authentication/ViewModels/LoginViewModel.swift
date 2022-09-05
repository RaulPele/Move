//
//  LoginViewModel.swift
//  Move
//
//  Created by Raul Pele on 18.08.2022.
//

import Foundation

extension LoginView {
    class LoginViewModel: ObservableObject {
        var errorHandler: ErrorHandler = MyErrorHandler.shared

        @Published var email: String = ""
        @Published var password: String = ""
        @Published var isLoading = false
        
        private let authenticationService: AuthenticationService = AuthenticationAPIService()

        init() {
            
        }
        
        init(errorHandler: ErrorHandler) {
            self.errorHandler = errorHandler
        }
        
        var fieldsCompleted: Bool {
            return !email.isEmpty && !password.isEmpty
        }
        
        func login(onLoginCompleted: @escaping () -> Void, onError: @escaping (Error) -> Void) {
            authenticationService.login(email: email, password: password) { result in
                self.isLoading = false
                switch result {
                case .success(_):
                    onLoginCompleted()
                case .failure(let error):
                    onError(error)
                }
            }
        }
        
    }
}
