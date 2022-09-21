//
//  DrivingLicenseVerificationCoordinatorView.swift
//  Move
//
//  Created by Raul Pele on 05.09.2022.
//

import SwiftUI

enum DrivingLicenseVerificationCoordinatorState {
    case verification
    case pending
    case valid
}

struct DrivingLicenseVerificationCoordinatorView: View {
    let errorHandler: ErrorHandler
    let drivingLicenseService: DrivingLicenseService
    let sessionManager: SessionManager
    
    @State private var state: DrivingLicenseVerificationCoordinatorState? = .verification
    let onBackButtonPressed: () -> Void
    let onVerificationFinished: () -> Void
    
    var body: some View {
        NavigationView {
            ZStack {
                NavigationLink(tag: .verification, selection: $state) {
                    DrivingLicenseVerificationView(errorHandler: errorHandler, drivingLicenseService: drivingLicenseService, sessionManager: sessionManager, onVerificationPending: {
                        state = .pending
                    }, onVerificationFinished: {
                        state = .valid
                    }, onBackButtonPressed: {
                        onBackButtonPressed()
                    })
                    .navigationBarHidden(true)
                } label: {
                    EmptyView()
                }
                
                NavigationLink(tag: .pending, selection: $state) {
                    DrivingLicensePendingVerificationView()
                        .navigationBarHidden(true)
                    
                } label: {
                    EmptyView()
                }
                
                NavigationLink(tag: .valid, selection: $state) {
                    ValidLicenseView(onOpenMap: onVerificationFinished)
                        .navigationBarHidden(true)
                    
                } label: {
                    EmptyView()
                }
            }
        }
    }
}

struct DrivingLicenseVerificationCoordinatorView_Previews: PreviewProvider {
    static var previews: some View {
        DrivingLicenseVerificationCoordinatorView(errorHandler: SwiftMessagesErrorHandler(), drivingLicenseService: DrivingLicenseAPIService(), sessionManager: SessionManager(), onBackButtonPressed: {}, onVerificationFinished: {})
    }
}
