//
//  APIConfig.swift
//  Move
//
//  Created by Raul Pele on 02.09.2022.
//

import Foundation

struct APIConfig {
    var baseUrl: URL
    
    init(baseUrlString: String) {
        self.baseUrl = URL(string: baseUrlString)!
    }
    
    func getUrl(for service: EndPoint) -> URL {
        let url = baseUrl.appendingPathComponent(service.rawValue)
        return url
    }
}

enum EndPoint: String {
    case login = "auth/login"
    case register = "auth/register"
    case drivingLicenseVerification = "users/addImage"
    case getAllScooters = "scooters"
    case scanScooter = "scooters/scan"
    case scanPhysicalScooter = "scooters/scanPhysical"
    case cancelScan = "scooters/cancel"
    case cancelPhysicalScan = "scooters/cancelPhysical"
    case startRide = "trips/start"
    case startPhysicalRide = "trips/startPhysical"
    case endRide = "trips/end"
    case endPhysicalRide = "trips/endPhysical"
    case lockRide = "trips/lock"
    case lockPhysicalRide = "trips/lockPhysical"
    case unlockRide = "trips/unlock"
    case unlockPhysicalRide = "trips/unlockPhysical"
    case rideInformation = "trips/current"
    case getUser = "users/me"
    case logout = "auth/logout"
    
    
}
