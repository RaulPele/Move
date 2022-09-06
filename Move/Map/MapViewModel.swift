//
//  MapViewModel.swift
//  Move
//
//  Created by Raul Pele on 06.09.2022.
//

import Foundation
import MapKit

extension MapView {
    class MapViewModel: ObservableObject {
        @Published var scooterLocations = [Scooter]()
        @Published var mapRegion = MKCoordinateRegion()
        
        let scooterService: ScooterService = ScooterMockedService()
        
        init() {
            scooterLocations = scooterService.getAllScooters()
        }
    }
}
