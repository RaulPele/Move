//
//  EndTripResponse.swift
//  Move
//
//  Created by Raul Pele on 03.10.2022.
//

import Foundation

struct EndTripResponse: Codable {
    let scooterDTO: ScooterDTO
    let userDTO: UserDTO
    let tripDTO: TripDTO
    
    enum CodingKeys: String, CodingKey {
        case scooterDTO = "updatedScooter"
        case userDTO = "updatedUser"
        case tripDTO = "endedTrip"
    }
}
