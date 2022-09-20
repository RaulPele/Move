//
//  ScooterCardViewModel.swift
//  Move
//
//  Created by Raul Pele on 15.09.2022.
//

import Foundation
import CoreLocation

extension ScooterCardView {
    class ScooterCardViewModel: ObservableObject {
        @Published var scooter: Scooter
        @Published var scooterAddress = ""
        
        init(scooter: Scooter) {
            self.scooter = scooter
        }
        
        func convertScooterLocation() {
            GeocoderProxy.shared.reverseGeocodeLocation(location: CLLocation(latitude: scooter.location.latitude, longitude: scooter.location.longitude), allowCaching: true,  completionHandler: { [weak self] placemarks, error in
                
                if let error = error {
                    print("ERROR RETRIEVING LOCATION: \(error.localizedDescription)")
                }
                guard let self = self else {
                    return
                }
                
                
                guard let placemarks = placemarks,
                      let placemark = placemarks.first else {
                    print("no placemarks available")
                    return
                }
                
                guard let street = placemark.thoroughfare,
                      let number = placemark.subThoroughfare else {
                    return
                }
                self.scooterAddress = "Str. \(street) \(number)"
                print("ADDRESS: \(self.scooterAddress)")
            })
        }
        
    }
}
