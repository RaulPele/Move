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
        
        init(scooter: Scooter, userLocation: CLLocation, rideService: RideService) {
            self.scooter = scooter
            self.rideService = rideService
            self.userLocation = userLocation
        }
        
        func startRide(onSuccess: @escaping (Scooter, Trip) -> Void, onError : @escaping (Error) -> Void) {
            rideService.startRide(scooterNumber: scooter.scooterNumber, userLocation: userLocation) { result in
                switch result {
                case .success(let tripData):
                    onSuccess(tripData.scooter, tripData.trip)
                case .failure(let error):
                    onError(error)
                }
            }
        }
    }
}
