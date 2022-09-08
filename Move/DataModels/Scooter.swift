//
//  Scooter.swift
//  Move
//
//  Created by Raul Pele on 06.09.2022.
//

import Foundation
import MapKit

enum ScooterStatus {
    case locked
    case unlocked
}

struct Scooter: Identifiable, Equatable {
    let id: String
    var status: ScooterStatus
    var batteryPercentage: Int
    var location: CLLocationCoordinate2D
    
    static func == (lhs: Scooter, rhs: Scooter) -> Bool {
        return lhs.id == rhs.id
    }
}
