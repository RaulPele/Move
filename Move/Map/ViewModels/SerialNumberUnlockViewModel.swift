//
//  SerialNumberUnlockViewModel.swift
//  Move
//
//  Created by Raul Pele on 20.09.2022.
//

import Foundation
import MapKit

extension SerialNumberUnlockView {
    class SerialNumberUnlockViewModel: ObservableObject {
        @Published var text: String = ""
        @Published var isLoading = false
        let scooter: Scooter
        let scooterService: ScooterService
        let userLocation: CLLocation
        
        init(scooterService: ScooterService,
             scooter: Scooter,
             userLocation: CLLocation) {
            self.scooter = scooter
            self.scooterService = scooterService
            self.userLocation = userLocation
            
        }
        
        func validatePin(onSuccess: () -> Void, onError: () -> Void) {
            if text.count == 4 {
                onSuccess()
            } else {
                onError()
            }
        }
        
        func unlock(onUnlockedSuccessfuly: @escaping () -> Void, onError: @escaping (Error) -> Void) {
            scooterService.unlock(scooter: scooter, userLocation: userLocation, unlockMethod: .PIN) { result in
                switch result {
                case .success(let scooter):
                    onUnlockedSuccessfuly()
                    
                case .failure(let error) :
                    onError(error)
                }
            }
            
        }
    }
}
