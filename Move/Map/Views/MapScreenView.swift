//
//  MapScreenView.swift
//  Move
//
//  Created by Raul Pele on 07.09.2022.
//

import SwiftUI

struct MapScreenView: View {
    let scooterService: ScooterService
    @StateObject private var mapScreenViewModel : MapScreenViewModel
    
    init(scooterService: ScooterService) {
        self.scooterService = scooterService
        self._mapScreenViewModel = StateObject(wrappedValue: MapScreenViewModel(scooterService: scooterService))

    }
    
    var body: some View {
        ZStack {
            ScooterMapView(mapViewModel: mapScreenViewModel.scooterMapViewModel)
                .onAppear() {
                    mapScreenViewModel.scooterMapViewModel.checkIfLocationServicesIsEnabled()
                }
                .halfSheet(showSheet: $mapScreenViewModel.showUnlockSheet) {
                    if let selectedScooter = mapScreenViewModel.selectedScooter {
                        UnlockScooterBottomSheetView(scooter: selectedScooter)
                    }
                } onDismiss: {
                    mapScreenViewModel.showUnlockSheet = false
                }
        }
        .ignoresSafeArea()
        .onAppear {
            mapScreenViewModel.initializeMapScreen()
        }
        .overlay(
            selectedScooterView
                .id(UUID())
                .transition(.opacity.animation(.easeInOut))
            , alignment: .bottom)
        .overlay(topBar, alignment: .top)
    }
    
    @ViewBuilder
    var selectedScooterView: some View {
        if let selectedScooter = mapScreenViewModel.selectedScooter {
            ScooterCardView(scooter: selectedScooter, onUnlockScooterPressed: {
                mapScreenViewModel.showUnlockSheet = true
            })
        }
    }
    
    var topBar: some View {
        HStack {
            Button {
                
            } label: {
                Image("menu-icon")
            }
            .buttonStyle(.roundedIconButton)
            
            Spacer()
            
            Text(mapScreenViewModel.currentLocation)
                .font(.heading3())
                .foregroundColor(.primaryLight)
                .onTapGesture {
                    mapScreenViewModel.scooterMapViewModel.onLocationHeaderTapped()
                }
            
            Spacer()
            
            Button {
                self.mapScreenViewModel.scooterMapViewModel.toggleUserLocationTracking()
            } label: {
                Image(self.mapScreenViewModel.scooterMapViewModel.isTrackingUserLocation ? "tracking-location-icon" : "not-tracking-location-icon")
            }
            .buttonStyle(.roundedIconButton)

        }
        .padding(.horizontal, 24)
        .padding(.top, 10)
//        .background(LinearGradient(colors: [.neutralWhite, .clear], startPoint: .top, endPoint: .bottom))
        
    }
}


struct MapScreenView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(devices) { device in
            MapScreenView(scooterService: ScooterAPIService())
                .previewDevice(device)
        }
    }
}
