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
            
            scooterMapViewModel.onScooterSelected = { [weak self] scooter in
                guard let self = self else {
                    return
                }
                self.selectedScooter = scooter
            }
            
            scooterMapViewModel.onScooterDeselected = { [weak self] in
                guard let self = self else {
                    return
                }
                self.selectedScooter = nil
            }
        }
        
        func loadScooters() {
           scooterService.getAllScooters() { result in
                switch result {
                case .success(let scooters):
                    var scooterAnnotations = [ScooterAnnotation]()
                    
                    for scooter in scooters {
                        
                        let annotation = ScooterAnnotation(coordinate: scooter.location, scooter: scooter)
                        scooterAnnotations.append(annotation)
                    }
                    
                    self.scooterMapViewModel.scooterAnnotations = scooterAnnotations
                    
                case .failure(let error):
                    print("Error getting scooters: \(error.localizedDescription)")
                }
            }
           
        }
    }
}
