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
    
    let scooterService: ScooterService
    let errorHandler: ErrorHandler
    
    init(errorHandler: ErrorHandler,
         scooterService: ScooterService) {
        self.scooterService = scooterService
        self.errorHandler = errorHandler
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                NavigationLink(tag: .map, selection: $mapCoordinatorViewModel.state) {
                        
                    MapScreenView(scooterService: scooterService, onSerialNumberUnlockClicked: {
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
        MapCoordinatorView(errorHandler: SwiftMessagesErrorHandler(), scooterService: ScooterAPIService(sessionManager: .init()))
    }
}
