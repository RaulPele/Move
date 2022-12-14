//
//  StartRideSheetViewModel.swift
//  Move
//
//  Created by Raul Pele on 03.10.2022.
//

import Foundation
import MapKit

extension StartRideSheetView {
    class StartRideSheetViewModel: ObservableObject {
        let rideService: RideService
        let scooter: Scooter
        let userLocation: CLLocation
        @Published var isWaitingForEndRide = false
        
        init(scooter: Scooter, userLocation: CLLocation, rideService: RideService) {
            self.scooter = scooter
            self.rideService = rideService
            self.userLocation = userLocation
        }
        
        func startRide(onSuccess: @escaping (Scooter, Trip) -> Void, onError : @escaping (Error) -> Void) {
            print("scooter id: \(scooter.id)")
            self.isWaitingForEndRide = true
            
            rideService.startRide(scooterId: scooter.id, userLocation: userLocation) { result in
                switch result {
                case .success(let tripData):
                    onSuccess(tripData.scooter, tripData.trip)
                case .failure(let error):
                    onError(error)
                }
                
                self.isWaitingForEndRide = false
            }
        }
    }
}
