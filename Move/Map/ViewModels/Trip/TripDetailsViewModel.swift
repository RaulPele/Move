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
    @Published var duration: Int = 0
    @Published private var isTravelTimerRunning = false
    @Published private var isRideInformationTimerRunning = false
    
    var rideService: RideService?
    var scooterMapViewModel: ScooterMapViewModel?
    
    func endRide(onSuccess: @escaping (Scooter, Trip) -> Void, onError: @escaping (Error) -> Void) {
        guard let userLocation = scooterMapViewModel?.userLocation else { return }
        rideService?.endRide(scooterId: scooter!.id, userLocation: userLocation) {[weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let tripData):
                self.stopMonitorizingRide()
                onSuccess(tripData.scooter, tripData.trip)
            case .failure(let error):
                onError(error)
            }
        }
    }
    
    private func startTravelTimer() {
        duration = 0
        isTravelTimerRunning = true
        
        let travelTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] timer in
                guard let self = self else { return }
            
            if self.isTravelTimerRunning {
                self.duration += 1
            }
        }
    }
    
    private func stopTravelTimer() {
        self.isTravelTimerRunning = false
    }
    
    private func startRideInformationTimer() {
        self.isRideInformationTimerRunning = true
        
        let rideInformationTimer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { timer in
            // request information data
        }
    }
    
    private func stopRideInformationTimer() {
        self.isRideInformationTimerRunning = false
    }
    
    func startMonitorizingRide() {
        startTravelTimer()
        startRideInformationTimer()
    }
    
    func stopMonitorizingRide() {
        stopTravelTimer()
        stopRideInformationTimer()
    }
}
