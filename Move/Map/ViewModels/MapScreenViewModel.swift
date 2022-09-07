//
//  MapViewModel.swift
//  Move
//
//  Created by Raul Pele on 06.09.2022.
//

import Foundation
import MapKit
import SwiftUI

extension MapScreenView {
    class MapScreenViewModel: ObservableObject {
        var scooterMapViewModel: ScooterMapViewModel
        let scooterService: ScooterService
        
        init(scooterService: ScooterService) {
            self.scooterService = scooterService
            scooterMapViewModel =  .init(scooterService: scooterService)
        }
        
        func loadScooters() {
            let scooters = scooterService.getAllScooters()
            var scooterAnnotations = [ScooterAnnotation]()
            
            for scooter in scooters {
                
                let annotation = ScooterAnnotation(coordinate: scooter.location, title: scooter.id, subtitle: "Status: \(scooter.status), Battery: \(scooter.batteryPercentage)")
                scooterAnnotations.append(annotation)
            }
            
            scooterMapViewModel.scooters = scooterAnnotations
        }
    }
}
