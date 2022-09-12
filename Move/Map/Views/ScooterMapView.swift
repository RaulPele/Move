//
//  MapView.swift
//  Move
//
//  Created by Raul Pele on 05.09.2022.
//

import SwiftUI
import MapKit

struct ScooterMapView: UIViewRepresentable {
    var mapViewModel: ScooterMapViewModel
    
    func makeUIView(context: Context) -> MKMapView {
        return mapViewModel.mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        
    }
}

//struct MapView_Previews: PreviewProvider {
//    
//    static var previews: some View {
//        ForEach(devices) { device in
//            MapView(centerCoordinate: .constant(Coordinates.ClujNapoca), annotations: .constant(mapScreenView))
//                .ignoresSafeArea()
//                .previewDevice(device)
//                
//        }
//    }
//}
