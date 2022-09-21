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
        let sessionManager: SessionManager
        let userLocation: CLLocation
        
        init(scooterService: ScooterService,
             sessionManager: SessionManager,
             scooter: Scooter,
             userLocation: CLLocation) {
            self.scooter = scooter
            self.scooterService = scooterService
            self.sessionManager = sessionManager
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
            guard let sessionToken = sessionManager.getSessionToken() else { return }
            
            
            scooterService.unlock(scooter: scooter, userLocation: userLocation, unlockMethod: .PIN, sessionToken: sessionToken) { result in
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
