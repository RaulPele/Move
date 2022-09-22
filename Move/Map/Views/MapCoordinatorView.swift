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
    let sessionManager: SessionManager
    let errorHandler: ErrorHandler
    
    init(errorHandler: ErrorHandler,
         scooterService: ScooterService,
         sessionManager: SessionManager) {
        self.scooterService = scooterService
        self.errorHandler = errorHandler
        self.sessionManager = sessionManager
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                NavigationLink(tag: .map, selection: $mapCoordinatorViewModel.state) {
//                    ZStack{
                    MapScreenView(scooterService: scooterService, onSerialNumberUnlockClicked: {
                        mapCoordinatorViewModel.state = .unlockScooterSerialNumber
                    }, onScooterSelectedForUnlock: { scooter, userLocation in
                        mapCoordinatorViewModel.currentScooter = scooter
                        mapCoordinatorViewModel.userLocation = userLocation
                        
                        if mapCoordinatorViewModel.userLocation != nil {
                            mapCoordinatorViewModel.showUnlockSheet = true
                        }
                        
                    })
//                        if let currentScooter = mapCoordinatorViewModel.currentScooter {
//                            Sheet(showSheet: $mapCoordinatorViewModel.showUnlockSheet, sheetMode: .half, content: {
//                                UnlockScooterBottomSheetView(scooter: currentScooter) { scooter in
//                                    mapCoordinatorViewModel.showUnlockSheet = false
//                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
//                                        mapCoordinatorViewModel.state = .unlockScooterSerialNumber
//                                    }
//                                }
//
//                            })}
//                }
                        
                    .navigationBarHidden(true)
                        .halfSheet(showSheet: $mapCoordinatorViewModel.showUnlockSheet) {
                            if let currentScooter = mapCoordinatorViewModel.currentScooter {
                                withAnimation {
                                    UnlockScooterBottomSheetView(scooter: currentScooter) { scooter in
                                        mapCoordinatorViewModel.showUnlockSheet = false
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                                            mapCoordinatorViewModel.state = .unlockScooterSerialNumber
                                        }
                                    }
                                }

                            }
                        } onDismiss: {
                            mapCoordinatorViewModel.showUnlockSheet = false
                        }
                    
//                        .halfSheet(showSheet: $mapCoordinatorViewModel.showStartRideSheet) {
//                            if let currentScooter = mapCoordinatorViewModel.currentScooter {
//                                ScooterDetailsSheetView(scooter: currentScooter)
//                            }
//                            
//                        } onDismiss: {
//                            mapCoordinatorViewModel.showStartRideSheet = false
//                        }

                } label: {
                    EmptyView()
                }
                
                NavigationLink(tag: .unlockScooterSerialNumber, selection: $mapCoordinatorViewModel.state) {
                    if let currentScooter = mapCoordinatorViewModel.currentScooter,
                       let userLocation = mapCoordinatorViewModel.userLocation {
                        SerialNumberUnlockView(errorHandler: errorHandler,
                                               scooterService: scooterService,
                                               sessionManager: sessionManager,
                                               scooter: currentScooter,
                                               userLocation: userLocation,
                                               onUnlockedSuccessfully: {
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
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
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
        MapCoordinatorView(errorHandler: SwiftMessagesErrorHandler(), scooterService: ScooterAPIService(), sessionManager: SessionManager())
    }
}
