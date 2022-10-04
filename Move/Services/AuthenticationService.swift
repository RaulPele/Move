//
//  AuthenticationService.swift
//  Move
//
//  Created by Raul Pele on 05.09.2022.
//

import Foundation

protocol AuthenticationService {
    func login(email: String, password: String, completionHandler: @escaping (Result<User, Error>) -> Void)
    func register(email: String, password: String, username: String, completionHandler: @escaping (Result<User, Error>) -> Void)
    func logout(completionHandler: @escaping (Result<String, Error>) -> Void)
}
