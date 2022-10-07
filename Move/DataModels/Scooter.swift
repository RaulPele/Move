//
//  Scooter.swift
//  Move
//
//  Created by Raul Pele on 06.09.2022.
//

import Foundation
import MapKit

enum BookedStatus: String, Codable {
    case available
    case scanned
    case booked
    case locked
    case disabled
}

enum LockedStatus: String, Codable {
    case locked
    case unlocked
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
    
    var isLocked: Bool {
        return self.bookedStatus == .locked
    }
    
    static func == (lhs: Scooter, rhs: Scooter) -> Bool {
        return lhs.id == rhs.id
    }
}
