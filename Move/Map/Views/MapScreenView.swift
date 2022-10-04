//
//  MapScreenView.swift
//  Move
//
//  Created by Raul Pele on 07.09.2022.
//

import SwiftUI
import MapKit
struct MapScreenView: View {
    let onSerialNumberUnlockClicked: () -> Void
    let onScooterSelectedForUnlock: (Scooter, CLLocation?) -> Void
    let onMenuButtonClicked: () -> Void
    
    @ObservedObject  var mapScreenViewModel : MapScreenViewModel
    
    init(
        viewModel: MapScreenViewModel,
         onSerialNumberUnlockClicked: @escaping () -> Void,
         onScooterSelectedForUnlock: @escaping (Scooter, CLLocation?) -> Void,
        onMenuButtonClicked: @escaping () -> Void) {
        self.onSerialNumberUnlockClicked = onSerialNumberUnlockClicked
        self.onScooterSelectedForUnlock = onScooterSelectedForUnlock
        self.onMenuButtonClicked = onMenuButtonClicked
        self.mapScreenViewModel = viewModel
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
            mapScreenViewModel.initializeMapScreen()
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
            ScooterCardView(scooter: selectedScooter, onUnlockScooterPressed: {
                onScooterSelectedForUnlock(selectedScooter, mapScreenViewModel.scooterMapViewModel.userLocation)
            })
            .id(selectedScooter.id)
        }
    }
    
    var topBar: some View {
        HStack {
            Button {
                onMenuButtonClicked()
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


//struct MapScreenView_Previews: PreviewProvider {
//    static var previews: some View {
//        ForEach(devices) { device in
//            MapScreenView(scooterService: ScooterAPIService(sessionManager: .init()), onSerialNumberUnlockClicked: {  }, onScooterSelectedForUnlock: { _, _ in })
//                .previewDevice(device)
//        }
//    }
//}
