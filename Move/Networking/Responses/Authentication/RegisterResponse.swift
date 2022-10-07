//
//  AuthenticationData.swift
//  Move
//
//  Created by Raul Pele on 02.09.2022.
//

import Foundation

struct RegisterResponse: Codable {
    var userDTO: UserDTO
    var token: String
    
    enum CodingKeys: String, CodingKey {
        case userDTO = "registeredUser"
        case token
    }
}
