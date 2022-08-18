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
    
    var fieldsCompleted: Bool {
        return !email.isEmpty && !password.isEmpty
    }
}
