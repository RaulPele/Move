//
//  MapCoordinatorViewModel.swift
//  Move
//
//  Created by Raul Pele on 21.09.2022.
//

import Foundation
import MapKit
import SwiftUI

extension MapCoordinatorView {
    class MapCoordinatorViewModel: ObservableObject {
        @Published var state: MapCoordinatorState? = .map
        @Published var showUnlockSheet = false
        @Published var showStartRideSheet = false
        @Published var showTripDetailsSheet = false
        @Published var showMenu = false
        @Published var currentTrip: Trip?
        @Published var showHistory = false
        
        var currentScooter: Scooter? = nil
        var userLocation: CLLocation? = nil
    }
    
    
}
