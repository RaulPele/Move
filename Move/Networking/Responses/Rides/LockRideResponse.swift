//
//  LockRideResponse.swift
//  Move
//
//  Created by Raul Pele on 07.10.2022.
//

import Foundation

struct LockRideResponse: Codable {
    let userDTO: UserDTO
    let scooterDTO: ScooterDTO
    let tripDTO: TripDTO
    
    enum CodingKeys: String, CodingKey {
        case userDTO = "updatedUser"
        case scooterDTO = "updatedScooter"
        case tripDTO = "updatedTrip"
    }
    
}
