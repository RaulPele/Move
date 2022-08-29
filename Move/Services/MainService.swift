//
//  MainService.swift
//  Move
//
//  Created by Raul Pele on 29.08.2022.
//

import Foundation

protocol Services {
    var authenticationService: AuthenticationService {get}
    
    func login(email: String, password: String, onLoginCompleted: @escaping () -> Void)
    
}

//class MainService: Services {
//    var authenticationService: AuthenticationService
//    
//    ini
//    
//    func login(email: String, password: String, onLoginCompleted: @escaping () -> Void) {
//        authenticationService.login(email: email, password: password, onLogin: onLoginCompleted)
//    }
//}
