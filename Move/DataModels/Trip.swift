//
//  Trip.swift
//  Move
//
//  Created by Raul Pele on 03.10.2022.
//

import Foundation
import MapKit

enum TripStatus: String, Codable {
    case inProgress = "in progress"
    case ended = "ended"
    case paused = "paused"
}

struct Trip {
    let startLocation: CLLocation
    let endLocation: CLLocation
    let userId: String
    let scooterId: String
    let status: TripStatus
    let distance: Double
    let duration: Double
    let allLocations: Array<CLLocation>
    let cost: Double

}
