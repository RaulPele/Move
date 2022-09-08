//
//  Scooter.swift
//  Move
//
//  Created by Raul Pele on 06.09.2022.
//

import Foundation
import MapKit

enum BookedStatus: String, Codable {
    case free
}

enum LockedStatus: String, Codable {
    case available
}

struct Scooter: Identifiable, Equatable {
    
    let id: String
    let scooterNumber: Int
    var bookedStatus: BookedStatus
    var lockedStatus: LockedStatus
    var batteryPercentage: Int
    var location: CLLocationCoordinate2D
    
    static func == (lhs: Scooter, rhs: Scooter) -> Bool {
        return lhs.id == rhs.id
    }
}
