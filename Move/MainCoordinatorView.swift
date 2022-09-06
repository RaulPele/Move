//
//  AppCoordinatorView.swift
//  Move
//
//  Created by Raul Pele on 12.08.2022.
//

import SwiftUI

enum MainCoordinatorState {
    case start
    case onboarding
    case authentication
    case drivingLicenseVerification
    case map
}

struct MainCoordinatorView: View {
    let errorHandler: ErrorHandler
    
    @State private var state: MainCoordinatorState? = MainCoordinatorState.start
    
    init(errorHandler: ErrorHandler) {
        self.errorHandler = errorHandler
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                NavigationLink(tag: .start, selection: $state) {
                    SplashView() {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            state = .onboarding
                        }
                    }
                    .navigationBarHidden(true)
                } label: {
                    EmptyView()
                }

                NavigationLink(tag: .onboarding, selection: $state) {
                    OnboardingCoordinatorView() {
                        state = .authentication
                    }
                    .navigationBarHidden(true)
                } label: {
                    EmptyView()
                }
                
                NavigationLink(tag: .authentication, selection: $state) {
                    AuthenticationCoordinatorView(errorHandler: errorHandler) {
                        state = .drivingLicenseVerification
                    } onRegisterCompleted: {
                        state = .drivingLicenseVerification
                    }
                    .navigationBarHidden(true)

                } label: {
                    EmptyView()
                }
                
                NavigationLink(tag: .drivingLicenseVerification, selection: $state) {
                    DrivingLicenseVerificationCoordinatorView(errorHandler: errorHandler) {
                        state = .authentication
                    } onVerificationFinished: {
                        state = .map
                    }
                    .navigationBarHidden(true)

                } label: {
                    EmptyView()
                }
                
                NavigationLink(tag: .map, selection: $state) {
                    MapView()
                        .navigationBarHidden(true)
                } label: {
                    EmptyView()
                }
            }
        }
    }
}

struct MainCoordinatorView_Previews: PreviewProvider {
    static var previews: some View {
        MainCoordinatorView(errorHandler: SwiftMessagesErrorHandler())
    }
}
