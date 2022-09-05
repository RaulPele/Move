//
//  AuthenticationData.swift
//  Move
//
//  Created by Raul Pele on 02.09.2022.
//

import Foundation

struct AuthenticationResponse: Codable {
    var userDTO: UserDTO
    var token: String
    
    enum CodingKeys: String, CodingKey {
        case userDTO = "user"
        case token
    }
}
