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

struct Scooter: Identifiable {
    let id: String
    var status: ScooterStatus
    var batteryPercentage: Int
    var location: CLLocationCoordinate2D
}
