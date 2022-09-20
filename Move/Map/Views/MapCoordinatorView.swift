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
    @State private var state: MapCoordinatorState? = .map
    
    let scooterService: ScooterService
    @State var selectedScooter: Scooter? = nil
    
    init(scooterService: ScooterService) {
        self.scooterService = scooterService
        
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                NavigationLink(tag: .map, selection: $state) {
                    MapScreenView(scooterService: scooterService, onSerialNumberUnlockClicked: { scooter in
                        state = .unlockScooterSerialNumber
                        self.selectedScooter = scooter
                    })
                        .navigationBarHidden(true)
//                        .halfSheet(showSheet: $showUnlockSheet) {
//                            if let selectedScooter = selectedScooter {
//                                UnlockScooterBottomSheetView(scooter: selectedScooter)
//                            }
//                        } onDismiss: {
//                            showUnlockSheet = false
//                        }

                } label: {
                    EmptyView()
                }
                
                NavigationLink(tag: .unlockScooterSerialNumber, selection: $state) {
                    if let selectedScooter = selectedScooter{
                        SerialNumberUnlockView(scooter: selectedScooter, onUnlockedSuccessfully: {
                            state = .unlockSuccessful
                        })
                            .navigationBarHidden(true)
                    }
                } label: {
                    EmptyView()
                }
                
                NavigationLink(tag: .unlockSuccessful, selection: $state) {
                    UnlockSuccessfulView()
                        .navigationBarHidden(true)
                } label: {
                    EmptyView()
                }

            }
        }
    }
}

struct MapCoordinatorView_Previews: PreviewProvider {
    static var previews: some View {
        MapCoordinatorView(scooterService: ScooterAPIService())
    }
}
