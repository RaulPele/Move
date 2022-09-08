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
            Spacer()
            selectedScooterView
        }
        .ignoresSafeArea()
        .onAppear {
            mapScreenViewModel.loadScooters()
        }
    }
    
    @ViewBuilder
    var selectedScooterView: some View {
        if let selectedScooter = mapScreenViewModel.selectedScooter {
            ScooterCardView(scooter: selectedScooter)
        }
    }
}


struct MapScreenView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(devices) { device in
            MapScreenView(scooterService: ScooterMockedService())
                .previewDevice(device)
        }
    }
}
