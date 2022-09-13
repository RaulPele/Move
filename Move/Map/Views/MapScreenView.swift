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
        }
        .ignoresSafeArea()
        .onAppear {
            mapScreenViewModel.loadScooters()
            mapScreenViewModel.startRefreshingScooters()
        }
        .overlay(
            selectedScooterView
                .transition(.opacity.animation(.easeInOut))
            , alignment: .bottom)
        .overlay(topBar, alignment: .top)
    }
    
    @ViewBuilder
    var selectedScooterView: some View {
        if let selectedScooter = mapScreenViewModel.selectedScooter {
            ScooterCardView(scooter: selectedScooter)
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
            
            Text("Allow location")
                .font(.heading3())
                .foregroundColor(.primaryLight)
            
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
