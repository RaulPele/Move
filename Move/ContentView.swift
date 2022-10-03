//
//  ContentView.swift
//  Move
//
//  Created by Raul Pele on 09.08.2022.
//

import SwiftUI

struct AppDependencies {
    let errorHandler: ErrorHandler
    let authenticationService: AuthenticationService
    let scooterService: ScooterService
    let sessionManager: SessionManager
    let drivingLicenseService: DrivingLicenseService
    let rideService: RideService
    
    init() {
        self.errorHandler = SwiftMessagesErrorHandler()
        self.sessionManager = SessionManager()
        self.authenticationService = AuthenticationAPIService(sessionManager: sessionManager)
        self.scooterService = ScooterAPIService(sessionManager: sessionManager)
        self.drivingLicenseService = DrivingLicenseAPIService(sessionManager: sessionManager)
        self.rideService = RideAPIService(sessionManager: sessionManager)
    }
}

struct ContentView: View {
    let appDependencies = AppDependencies()

    var body: some View {
        MainCoordinatorView(appDependencies: appDependencies)
//        MapCoordinatorView(errorHandler: appDependencies.errorHandler, scooterService: appDependencies.scooterService, sessionManager: appDependencies.sessionManager)
//        SerialNumberUnlockView()
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
