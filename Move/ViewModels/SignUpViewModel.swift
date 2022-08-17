//
//  SignUpViewModel.swift
//  Move
//
//  Created by Raul Pele on 17.08.2022.
//

import Foundation

class SignUpViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var username: String = ""
    @Published var password: String = ""
    
    var fieldsCompleted: Bool {
        return !email.isEmpty && !username.isEmpty && !password.isEmpty
    }
}
