//
//  UserResponse.swift
//  Move
//
//  Created by Raul Pele on 04.10.2022.
//

import Foundation

struct GetUserResponse: Codable {
    let userDTO: UserDTO
    let numberOfTrips: Int
    
    enum CodingKeys: String, CodingKey {
        case userDTO = "existingUser"
        case numberOfTrips = "nrOfTrips"
    }
}
