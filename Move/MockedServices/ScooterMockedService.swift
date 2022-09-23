//
//  ScooterMockedService.swift
//  Move
//
//  Created by Raul Pele on 06.09.2022.
//

import Foundation
import MapKit

class ScooterMockedService: ScooterService {
    func unlock(scooterPin: Int,
                userLocation: CLLocation,
                unlockMethod: UnlockMethod,
                completionHandler: @escaping (Result<Scooter, Error>) -> Void) {
        
    }
    
    func getAllScooters(completionHandler: @escaping (Result<[Scooter], Error>) -> Void) {
        completionHandler(.success([
            Scooter(id: "#AAAA", scooterNumber: 1234, bookedStatus: .free, lockedStatus: .available, batteryPercentage: 100, location: .init(latitude: 46.779, longitude: 23.6)),
            Scooter(id: "#BBBB", scooterNumber: 1111, bookedStatus: .free, lockedStatus: .available,  batteryPercentage: 84, location: .init(latitude: 46.78, longitude: 23.59)),
            Scooter(id: "#CCCC", scooterNumber: 2222, bookedStatus: .free, lockedStatus: .available,  batteryPercentage: 50, location: .init(latitude: 46.771, longitude: 23.585)),
            Scooter(id: "#1234", scooterNumber: 3333, bookedStatus: .free, lockedStatus: .available,  batteryPercentage: 10, location: .init(latitude: 46.75, longitude: 23.580))
        ]))
    }
    
    
}
