//
//  RideService.swift
//  Move
//
//  Created by Raul Pele on 03.10.2022.
//

import Foundation
import MapKit

protocol RideService {
    func startRide(scooterId: String,
                   userLocation: CLLocation,
                   completionHandler: @escaping (Result<TripData, Error>) -> Void)
    
    func endRide(scooterId: String,
                 userLocation: CLLocation,
                 completionHandler: @escaping (Result<TripData, Error>) -> Void)
    
    func getRideInformation(scooterId: String,
                            completionHandler: @escaping (Result<TripData, Error>) -> Void)
    
    func lockRide(scooterId: String,
                  userLocation: CLLocation,
                  completionHandler: @escaping (Result<TripData, Error>) -> Void)
    
    func unlockRide(scooterId: String,
                    userLocation: CLLocation,
                    completionHandler: @escaping (Result<TripData, Error>) -> Void)
}
