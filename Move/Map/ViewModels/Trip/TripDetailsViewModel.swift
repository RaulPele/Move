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
    
    @Published var isWaitingForLock = false
    @Published var isWaitingForEndRide = false
    
    
    var rideInformationTimer: Timer?
    
    var rideService: RideService?
    var scooterMapViewModel: ScooterMapViewModel?
    
    var isWaiting: Bool {
        return isWaitingForLock || isWaitingForEndRide
    }
    
    func endRide(onSuccess: @escaping () -> Void, onError: @escaping (Error) -> Void) {
        guard let userLocation = scooterMapViewModel?.userLocation else { return }
        self.isWaitingForEndRide = true
        
        rideService?.endRide(scooterId: scooter!.id, userLocation: userLocation) {[weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let tripData):
                self.stopMonitorizingRide()
                self.trip = tripData.trip
                self.scooter = tripData.scooter
                onSuccess()
            case .failure(let error):
                onError(error)
            }
            
            self.isWaitingForEndRide = false
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
        guard let rideService = rideService,
        let trip = trip else { return }
        
        self.isRideInformationTimerRunning = true
        
        rideInformationTimer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { timer in
            rideService.getRideInformation(scooterId: trip.scooterId) { result in
                switch result {
                case .success(let tripData):
                    self.trip = tripData.trip
                    self.scooter = tripData.scooter
                    
                case .failure(let error):
                    print("ERROR while getting trip information: \(error.localizedDescription)") // TODO: handle error
                }
            }
        }
    }
    
    private func stopRideInformationTimer() {
        self.isRideInformationTimerRunning = false
        rideInformationTimer?.invalidate()
    }
    
    func startMonitorizingRide() {
        startTravelTimer()
        startRideInformationTimer()
    }
    
    func stopMonitorizingRide() {
        stopTravelTimer()
        stopRideInformationTimer()
    }
    
    func lockRide(onSuccess: @escaping () -> Void, onError: @escaping (Error) -> Void) {
        guard let rideService = rideService,
        let userLocation = scooterMapViewModel?.userLocation,
        let scooter = scooter else { return }
        
        self.isWaitingForLock = true
        
        rideService.lockRide(scooterId: scooter.id, userLocation: userLocation) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let tripData):
                self.scooter = tripData.scooter
                self.trip = tripData.trip
                self.stopRideInformationTimer()
                
                onSuccess()
            case .failure(let error):
                onError(error)
            }
            self.isWaitingForLock = false
        }
    }
    
    func unlockRide(onSuccess: @escaping () -> Void, onError: @escaping (Error) -> Void) {
        guard let rideService = rideService,
        let userLocation = scooterMapViewModel?.userLocation,
        let scooter = scooter else { return }

        self.isWaitingForLock = true

        rideService.unlockRide(scooterId: scooter.id, userLocation: userLocation) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let tripData):
                self.scooter = tripData.scooter
                self.trip = tripData.trip
                self.startRideInformationTimer()
                
                onSuccess()
            case .failure(let error):
                onError(error)
            }
            self.isWaitingForLock = false

        }
    }
    

}
