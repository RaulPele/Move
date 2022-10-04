//
//  LoginResponse.swift
//  Move
//
//  Created by Raul Pele on 04.10.2022.
//

import Foundation

struct LoginResponse: Codable {
    var userDTO: UserDTO
    var token: String
    
    enum CodingKeys: String, CodingKey {
        case userDTO = "user"
        case token
    }
}
