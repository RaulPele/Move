//
//  MapViewModel.swift
//  Move
//
//  Created by Raul Pele on 06.09.2022.
//

import Foundation
import MapKit
import SwiftUI
import Combine

extension MapScreenView {
    class MapScreenViewModel: ObservableObject {
        @Published var scooterMapViewModel: ScooterMapViewModel
        let scooterService: ScooterService
        
        @Published var selectedScooter: Scooter?
        private var cancellables = [AnyCancellable]()
        
        init(scooterService: ScooterService) {
            self.scooterService = scooterService
            
            scooterMapViewModel =  .init(scooterService: scooterService)
            
            scooterMapViewModel.objectWillChange.sink { _ in
                self.objectWillChange.send()
            }.store(in: &cancellables)
            
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
        
        func startRefreshingScooters() {
            let reloadScootersTimer = Timer.scheduledTimer(withTimeInterval: 30, repeats: true) { _ in
                self.loadScooters()
            }
        }
        
    }
}
