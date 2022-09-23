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
        let scooterService: ScooterService
        let userLocation: CLLocation
        
        init(scooterService: ScooterService,
             userLocation: CLLocation) {
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
        
        func unlock(onUnlockedSuccessfuly: @escaping (Scooter) -> Void, onError: @escaping (Error) -> Void) {
            guard let scooterPin = Int(text) else {
                return
            }
            
            scooterService.unlock(scooterPin: scooterPin, userLocation: userLocation, unlockMethod: .PIN) { result in
                switch result {
                case .success(let scooter):
                    onUnlockedSuccessfuly(scooter)
                case .failure(let error) :
                    onError(error)
                }
            }
            
        }
    }
}
