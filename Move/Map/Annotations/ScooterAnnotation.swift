//
//  ScooterAnnotation.swift
//  Move
//
//  Created by Raul Pele on 07.09.2022.
//

import Foundation
import MapKit

class ScooterAnnotation: NSObject, MKAnnotation {
    let coordinate: CLLocationCoordinate2D
    let scooter: Scooter
    
    init(coordinate: CLLocationCoordinate2D, scooter: Scooter) {
        self.coordinate = coordinate
        self.scooter = scooter
    }
}
