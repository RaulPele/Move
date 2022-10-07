//
//  GetTripResponse.swift
//  Move
//
//  Created by Raul Pele on 04.10.2022.
//

import Foundation

struct GetTripResponse: Codable {
    let tripDTO: TripDTO
    let scooterDTO: ScooterDTO
    
    enum CodingKeys: String, CodingKey {
        case tripDTO = "trip"
        case scooterDTO = "scooter"
    }
}
