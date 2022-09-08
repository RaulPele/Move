//
//  ScooterDTO.swift
//  Move
//
//  Created by Raul Pele on 08.09.2022.
//

import Foundation
import CoreLocation

struct LocationDTO: Codable {
    let type: String
    let coordinates: [Double]
}

struct ScooterDTO: Codable {
    let location: LocationDTO
    let id: String
    let scooterNumber: Int
    let battery: Int
    let bookedStatus: BookedStatus
    let lockedStatus: LockedStatus
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case location
        case scooterNumber = "ScootNumber"
        case battery
        case bookedStatus = "booked_status"
        case lockedStatus = "lock_status"
    }
}

extension ScooterDTO {
    func toScooter() -> Scooter {
        return Scooter(id: id, scooterNumber: scooterNumber, bookedStatus: bookedStatus, lockedStatus: lockedStatus, batteryPercentage: battery, location: .init(latitude: location.coordinates[0], longitude: location.coordinates[1]))
    }
}

extension Array where Element == ScooterDTO {
    func toScooterArray() -> [Scooter] {
        var scooters = [Scooter]()
        
        for scooterDTO in self {
            scooters.append(scooterDTO.toScooter())
        }
        
        return scooters
    }
}
