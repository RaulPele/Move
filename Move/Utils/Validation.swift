//
//  Validation.swift
//  Move
//
//  Created by Raul Pele on 29.08.2022.
//

import Foundation

class Validation {
    static func validate(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    static func validate(password: String) -> Bool {
        return !password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    static func validate(username: String) -> Bool {
        return username.count >= 3 && !username.contains(" ")
    }
}
