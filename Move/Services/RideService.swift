//
//  RideService.swift
//  Move
//
//  Created by Raul Pele on 03.10.2022.
//

import Foundation
import MapKit

protocol RideService {
    func startRide(scooterNumber: Int,
                   userLocation: CLLocation,
                   completionHandler: @escaping (Result<TripData, Error>) -> Void)
}
