//
//  MapCoordinatorViewModel.swift
//  Move
//
//  Created by Raul Pele on 21.09.2022.
//

import Foundation
import MapKit

extension MapCoordinatorView {
    class MapCoordinatorViewModel: ObservableObject {
        @Published var state: MapCoordinatorState? = .map
        var currentScooter: Scooter? = nil
        var userLocation: CLLocation? = nil
    }
}
