//
//  TripDTO.swift
//  Move
//
//  Created by Raul Pele on 03.10.2022.
//

import Foundation
import MapKit

struct TripDTO: Codable {
    let startLocation: LocationDTO
    let endLocation: LocationDTO
    let userId: String
    let scooterId: String
    let status: TripStatus
    let distance: Double
    let duration: Double
    let cost: Double
    let allLocations: Array<LocationDTO>
    
    enum CodingKeys: String, CodingKey {
        case startLocation
        case endLocation
        case userId
        case scooterId
        case status
        case cost
        case distance
        case duration
        case allLocations
    }
    
    func toTrip() -> Trip {
        var allLocations = [CLLocation]()
        var endLocation = CLLocation()
        for locationDTO in self.allLocations {
            allLocations.append(CLLocation(latitude: locationDTO.coordinates[1], longitude: locationDTO.coordinates[0]))
        }
        
        if !self.endLocation.coordinates.isEmpty {
            endLocation = CLLocation(latitude: self.endLocation.coordinates[1], longitude:  self.endLocation.coordinates[0])
        }
        
        return .init(startLocation: .init(latitude: startLocation.coordinates[1], longitude: startLocation.coordinates[0]), endLocation: endLocation, userId: userId, scooterId: scooterId, status: status, distance: distance, duration: duration, allLocations: allLocations, cost: cost)
    }
}
