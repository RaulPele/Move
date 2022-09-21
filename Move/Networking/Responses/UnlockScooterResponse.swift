//
//  UnlockScooterResponse.swift
//  Move
//
//  Created by Raul Pele on 21.09.2022.
//

import Foundation

struct UnlockScooterResponse: Codable {
    let scooterDTO: ScooterDTO
    let userDTO: UserDTO
    
    enum CodingKeys: String, CodingKey {
        case scooterDTO = "updated_scooter"
        case userDTO = "updatedUser"
    }
}
