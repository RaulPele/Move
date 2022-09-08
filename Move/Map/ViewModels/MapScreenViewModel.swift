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
        
        @Published var selectedScooter: Scooter?
        
        init(scooterService: ScooterService) {
            self.scooterService = scooterService
            scooterMapViewModel =  .init(scooterService: scooterService)
            
            scooterMapViewModel.onScooterSelected = { scooter in
                self.selectedScooter = scooter
            }
        }
        
        func loadScooters() {
            let scooters = scooterService.getAllScooters()
            var scooterAnnotations = [ScooterAnnotation]()
            
            for scooter in scooters {
                
                let annotation = ScooterAnnotation(coordinate: scooter.location, scooter: scooter)
                scooterAnnotations.append(annotation)
            }
            
            scooterMapViewModel.scooterAnnotations = scooterAnnotations
        }
    }
}
