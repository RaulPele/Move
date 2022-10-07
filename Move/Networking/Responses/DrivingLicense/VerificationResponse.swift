//
//  VerificationResponse.swift
//  Move
//
//  Created by Raul Pele on 05.09.2022.
//

import Foundation

struct VerificationResponse: Codable {
    let userDTO : UserDTO
    
    enum CodingKeys: String, CodingKey {
        case userDTO = "existingUser"
    }
}
