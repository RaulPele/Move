//
//  TripDetailsViewModel.swift
//  Move
//
//  Created by Raul Pele on 03.10.2022.
//

import Foundation

class TripDetailsViewModel: ObservableObject {
    @Published var scooter: Scooter?
    @Published var trip: Trip?
    var rideService: RideService?
    var scooterMapViewModel: ScooterMapViewModel?
    
//    init( rideService: RideService, scooterMapViewModel: ScooterMapViewModel) {
//        self.rideService = rideService
//        self.scooterMapViewModel = scooterMapViewModel
//    }
    
    func endRide(onSuccess: @escaping (Scooter, Trip) -> Void, onError: @escaping (Error) -> Void) {
        guard let userLocation = scooterMapViewModel?.userLocation else { return }
        rideService?.endRide(scooterId: scooter!.id, userLocation: userLocation) { result in
            switch result {
            case .success(let tripData):
                onSuccess(tripData.scooter, tripData.trip)
            case .failure(let error):
                onError(error)
            }
        }
    }
}
