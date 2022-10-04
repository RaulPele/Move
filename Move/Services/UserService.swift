//
//  UserService.swift
//  Move
//
//  Created by Raul Pele on 04.10.2022.
//

import Foundation

protocol UserService {
    func getUser(completionHandler: @escaping (Result<User, Error>) -> Void )
}
