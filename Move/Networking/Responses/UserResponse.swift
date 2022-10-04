//
//  UserResponse.swift
//  Move
//
//  Created by Raul Pele on 04.10.2022.
//

import Foundation

struct UserResponse: Codable {
    let userDTO: UserDTO
    
    enum CodingKeys: String, CodingKey {
        case userDTO = "existingUser"
    }
}
