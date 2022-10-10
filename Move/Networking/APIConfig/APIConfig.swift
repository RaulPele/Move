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
    case cancelScan = "scooters/cancel"
    case startRide = "trips/start"
    case endRide = "trips/end"
    case lockRide = "trips/lock"
    case unlockRide = "trips/unlock"
    case rideInformation = "trips/current"
    case getUser = "users/me"
    case logout = "auth/logout"
    
    
}
