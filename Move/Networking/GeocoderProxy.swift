//
//  GeocoderProxy.swift
//  Move
//
//  Created by Raul Pele on 13.09.2022.
//

import Foundation
import CoreLocation

struct Location: Hashable {
    let latitude: Double
    let longitude: Double
}

class GeocoderProxy {
    private let geoCoder = CLGeocoder()
    private let cachedLocations = [Location : CLPlacemark]()
    
    func reverseGeocodeLocation(location: CLLocation, completionHandler: CoreLocation.CLGeocodeCompletionHandler) {
        location.hashValue
        if let locationPlacemark = cachedLocations[location] {
            
        }
    }
}
