//
//  Scooter.swift
//  Move
//
//  Created by Raul Pele on 06.09.2022.
//

import Foundation
import MapKit

enum BookedStatus: String, Codable {
    case free //no one is riding, battery > 10%
    case booked // else
}

enum LockedStatus: String, Codable {
    case available //if no one is riding or locked it, no problems with it, battery > 10 %
    case disabled // if battery low, its missing, something broke, technical issues
    case locked // locked if someone started a ride with it and didn't yet finish it
}

enum UnlockMethod: String, Codable {
    case PIN
}

struct Scooter: Identifiable, Equatable {
    let id: String
    let scooterNumber: Int
    var bookedStatus: BookedStatus
    var lockedStatus: LockedStatus
    var batteryPercentage: Int
    var location: CLLocationCoordinate2D
    
    init(id: String, scooterNumber: Int, bookedStatus: BookedStatus, lockedStatus: LockedStatus, batteryPercentage: Int, location: CLLocationCoordinate2D) {
        self.id = id
        self.scooterNumber = scooterNumber
        self.bookedStatus = bookedStatus
        self.lockedStatus = lockedStatus
        self.batteryPercentage = batteryPercentage
        self.location = location
    }
    
    static func == (lhs: Scooter, rhs: Scooter) -> Bool {
        return lhs.id == rhs.id
    }
}
