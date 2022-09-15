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
    
}

struct MapCoordinatorView: View {
    @State private var state: MapCoordinatorState? = .map
    @State private var selectedScooter: Scooter?
    @State private var showUnlockSheet = false
    

    let scooterService: ScooterService
    
    var body: some View {
        NavigationView {
            ZStack {
                NavigationLink(tag: .map, selection: $state) {
                    MapScreenView(scooterService: scooterService, onUnlockScooterPressed: {  selectedScooter in
                        
                        self.selectedScooter = selectedScooter
                        showUnlockSheet = true
                    })
                    .navigationBarHidden(true)
                    .halfSheet(showSheet: $showUnlockSheet) {
                        if let selectedScooter = selectedScooter {
                            UnlockScooterBottomSheetView(scooter: selectedScooter)
                        }
                    } onDismiss: {
//                        showUnlockSheet = false
                    }

                } label: {
                    EmptyView()
                }
                
                NavigationLink(tag: .unlockScooterSheet, selection: $state) {
                    
                } label: {
                    
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
