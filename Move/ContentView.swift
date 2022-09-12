//
//  ContentView.swift
//  Move
//
//  Created by Raul Pele on 09.08.2022.
//

import SwiftUI

struct AppDependencies {
    let errorHandler: ErrorHandler
    let sessionManager: SessionManager
    let authenticationService: AuthenticationService
    let scooterService: ScooterService
    let drivingLicenseService: DrivingLicenseService
    
    init() {
        self.errorHandler = SwiftMessagesErrorHandler()
        self.sessionManager = SessionManager()
        self.authenticationService = AuthenticationAPIService(sessionManager: sessionManager)
        self.scooterService = ScooterAPIService()
        self.drivingLicenseService = DrivingLicenseAPIService()
    }
}

struct ContentView: View {
    let appDependencies = AppDependencies()
    
    var body: some View {
//        MainCoordinatorView(appDependencies: appDependencies)
        MapScreenView(scooterService: appDependencies.scooterService)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
