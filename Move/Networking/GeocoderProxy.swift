//
//  GeocoderProxy.swift
//  Move
//
//  Created by Raul Pele on 13.09.2022.
//

import Foundation
import CoreLocation

extension CLLocationCoordinate2D: Hashable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.latitude)
        hasher.combine(self.longitude)
    }
}

class GeocoderProxy {
    private let geoCoder = CLGeocoder()
    private var cachedLocations = [CLLocationCoordinate2D : [CLPlacemark]]()
    static let shared = GeocoderProxy()
    
//    private init() {
//        
//    }
    
    func reverseGeocodeLocation(location: CLLocation, completionHandler: @escaping CoreLocation.CLGeocodeCompletionHandler) {
//        if let locationPlacemarks = cachedLocations[location.coordinate] {
//            print("Retrieved cached data")
//            completionHandler(locationPlacemarks, nil)
//        } else {
            print("Made new Request to geocode server")
            geoCoder.reverseGeocodeLocation(location) { [weak self] placemarks, error in
                guard let self = self else {
                    print("Failed to cache data")
                    completionHandler(placemarks, error)
                    return
                }
                
                if let placemarks = placemarks {
//                    self.cachedLocations[location.coordinate] = placemarks
                    print("Successfully cached location for: \(location.coordinate) = \(placemarks.first!.locality) \(placemarks.first!.thoroughfare)")
                }
                completionHandler(placemarks, error)
//            }
        }
    }
}
