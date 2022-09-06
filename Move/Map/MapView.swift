//
//  MapView.swift
//  Move
//
//  Created by Raul Pele on 05.09.2022.
//

import SwiftUI
import MapKit

struct MapView: View {
    @StateObject private var mapViewModel = MapViewModel()
    
    @State private var mapRegion = MKCoordinateRegion(center: Coordinates.ClujNapoca, span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))

        var body: some View {
            Map(coordinateRegion: $mapRegion, annotationItems: mapViewModel.scooterLocations) { scooter in
                MapMarker(coordinate: scooter.location)
            }
                .ignoresSafeArea()
        }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(devices) { device in
            MapView()
                .previewDevice(device)
        }
    }
}
