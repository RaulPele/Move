//
//  MapCoordinatorView.swift
//  Move
//
//  Created by Raul Pele on 15.09.2022.
//

import SwiftUI

enum MapCoordinatorState {
    case map
    case unlockScooterSheet
    case unlockScooterSerialNumber
    case unlockSuccessful
    
}

struct MapCoordinatorView: View {
    @StateObject private var mapCoordinatorViewModel: MapCoordinatorViewModel = .init()
    @StateObject private var mapScreenViewModel: MapScreenView.MapScreenViewModel
    @StateObject private var tripDetailsViewModel: TripDetailsViewModel = .init()
    
    let scooterService: ScooterService
    let rideService: RideService
    let errorHandler: ErrorHandler
    
    init(errorHandler: ErrorHandler,
         scooterService: ScooterService,
         rideService: RideService) {
        
        self.scooterService = scooterService
        self.errorHandler = errorHandler
        self.rideService = rideService
        self._mapScreenViewModel = .init(wrappedValue: .init(scooterService: scooterService))
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                NavigationLink(tag: .map, selection: $mapCoordinatorViewModel.state) {
                    
                    MapScreenView(viewModel: mapScreenViewModel,
                                  onSerialNumberUnlockClicked: {
                        mapCoordinatorViewModel.state = .unlockScooterSerialNumber
                    }, onScooterSelectedForUnlock: { scooter, userLocation in
                        mapCoordinatorViewModel.currentScooter = scooter
                        mapCoordinatorViewModel.userLocation = userLocation
                        
                        if mapCoordinatorViewModel.userLocation != nil {
                            mapCoordinatorViewModel.showUnlockSheet = true
                        }
                        
                    })
                    .navigationBarHidden(true)
                    .overlay {
                        if let currentScooter = mapCoordinatorViewModel.currentScooter,
                           mapCoordinatorViewModel.showUnlockSheet {
                            Sheet(showSheet: $mapCoordinatorViewModel.showUnlockSheet, content: {
                                UnlockScooterBottomSheetView(scooter: currentScooter) { scooter in
                                    mapCoordinatorViewModel.showUnlockSheet = false
                                    mapCoordinatorViewModel.state = .unlockScooterSerialNumber
                                }
                            })
                        }
                    }
                    .overlay {
                        if let unlockedScooter = mapCoordinatorViewModel.currentScooter,
                           let userLocation = mapCoordinatorViewModel.userLocation,
                           mapCoordinatorViewModel.showStartRideSheet {
                            Sheet(showSheet: $mapCoordinatorViewModel.showStartRideSheet) {
                                StartRideSheetView(errorHandler: errorHandler,
                                                   scooter: unlockedScooter,
                                                   userLocation: userLocation,
                                                   rideService: rideService) { scooter, trip in
                                    
                                    mapCoordinatorViewModel.currentScooter = scooter
                                    mapCoordinatorViewModel.showStartRideSheet = false
                                    
                                    //TODO: Definetly change this
                                    tripDetailsViewModel.trip = trip
                                    tripDetailsViewModel.scooter = scooter
                                    tripDetailsViewModel.scooterMapViewModel = mapScreenViewModel.scooterMapViewModel
                                    tripDetailsViewModel.rideService = rideService
                                    
                                    tripDetailsViewModel.startMonitorizingRide()
                                    
                                    mapCoordinatorViewModel.showTripDetailsSheet = true
                                    mapScreenViewModel.enterRideMode(currentScooterId: unlockedScooter.id)
                                    
                                }
                            } onDismiss: {
                                scooterService.cancelScan(scooterPin: unlockedScooter.scooterNumber) { result in
                                    switch result {
                                    case .success(let success):
                                        mapCoordinatorViewModel.showStartRideSheet = false
                                        mapCoordinatorViewModel.currentScooter = nil
                                    case .failure(let failure):
                                        print("failure cancelling scan")
                                    }
                                }
                            }
                        }
                    }
                    .overlay {
                        if mapCoordinatorViewModel.showTripDetailsSheet {
                            if mapCoordinatorViewModel.showTripDetailsSheet {
                                Sheet(showSheet: $mapCoordinatorViewModel.showTripDetailsSheet) {
                                    TripDetailsSheetView(viewModel: tripDetailsViewModel,
                                                         errorHandler: errorHandler) { scooter, trip in
                                        mapCoordinatorViewModel.showTripDetailsSheet = false
                                        mapScreenViewModel.exitRideMode()

                                        print("Ride ended")
                                    }
                                }
                            }
                        }
                    }
                    
                } label: {
                    EmptyView()
                }
                
                NavigationLink(tag: .unlockScooterSerialNumber, selection: $mapCoordinatorViewModel.state) {
                    if let userLocation = mapCoordinatorViewModel.userLocation {
                        SerialNumberUnlockView(errorHandler: errorHandler,
                                               scooterService: scooterService,
                                               userLocation: userLocation,
                                               onUnlockedSuccessfully: { unlockedScooter in
                            mapCoordinatorViewModel.currentScooter = unlockedScooter
                            mapCoordinatorViewModel.state = .unlockSuccessful
                        }, onClose: {
                            mapCoordinatorViewModel.state = .map
                        })
                        .navigationBarHidden(true)
                    }
                } label: {
                    EmptyView()
                }
                
                NavigationLink(tag: .unlockSuccessful, selection: $mapCoordinatorViewModel.state) {
                    UnlockSuccessfulView()
                        .navigationBarHidden(true)
                        .onAppear() {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                mapCoordinatorViewModel.state = .map
                                mapCoordinatorViewModel.showStartRideSheet = true
                            }
                        }
                } label: {
                    EmptyView()
                }
            }
        }
    }
    
    
}

struct MapCoordinatorView_Previews: PreviewProvider {
    static var previews: some View {
        MapCoordinatorView(errorHandler: SwiftMessagesErrorHandler(), scooterService: ScooterAPIService(sessionManager: .init()), rideService: RideAPIService(sessionManager: .init()))
    }
}
