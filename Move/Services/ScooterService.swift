//
//  File.swift
//  Move
//
//  Created by Raul Pele on 06.09.2022.
//

import Foundation
import MapKit

protocol ScooterService {
    func getAllScooters(completionHandler: @escaping (Result<[Scooter], Error>) -> Void)
    func unlock(scooterPin: Int,
                userLocation: CLLocation,
                unlockMethod: UnlockMethod,
                completionHandler: @escaping (Result<Scooter, Error>) -> Void)
    func cancelScan(scooterPin: Int,
                    completionHandler: @escaping (Result<Scooter, Error>) -> Void)
}
