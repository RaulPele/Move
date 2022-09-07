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
    
    init() {
        self.errorHandler = SwiftMessagesErrorHandler()
        self.sessionManager = SessionManager()
        self.authenticationService = AuthenticationAPIService(sessionManager: sessionManager)
        self.scooterService = ScooterMockedService()
    }
}

struct ContentView: View {
    let appDependencies = AppDependencies()
    
    var body: some View {
//        MainCoordinatorView(appDependencies: appDependencies)
        MapScreenView(scooterService: ScooterMockedService())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
