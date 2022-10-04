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
    let appDependencies: AppDependencies
    @State private var state: MainCoordinatorState? = MainCoordinatorState.start
    let flowManager: FlowManager
    
    init(appDependencies: AppDependencies) {
        self.appDependencies = appDependencies
        self.flowManager = appDependencies.flowManager
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                NavigationLink(tag: .start, selection: $state) {
                    SplashView() {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            flowManager.getApplicationFlow { state in
                                self.state = state
                            }
                        }
                    }
                    .navigationBarHidden(true)
                } label: {
                    EmptyView()
                }

                NavigationLink(tag: .onboarding, selection: $state) {
                    OnboardingCoordinatorView() {
                        flowManager.markAsOnboarded()
                        state = .authentication
                    }
                    .navigationBarHidden(true)
                } label: {
                    EmptyView()
                }
                
                NavigationLink(tag: .authentication, selection: $state) {
                    AuthenticationCoordinatorView(errorHandler: appDependencies.errorHandler, authenticationService: appDependencies.authenticationService) {
                        flowManager.getApplicationFlow(completionHandler: { state in
                            self.state = state
                        })
                    } onRegisterCompleted: {
                        flowManager.getApplicationFlow(completionHandler: { state in
                            self.state = state
                        })
                    }
                    .navigationBarHidden(true)

                } label: {
                    EmptyView()
                }
                
                NavigationLink(tag: .drivingLicenseVerification, selection: $state) {
                    DrivingLicenseVerificationCoordinatorView(errorHandler: appDependencies.errorHandler, drivingLicenseService: appDependencies.drivingLicenseService) {
                        state = .authentication
                    } onVerificationFinished: {
                        flowManager.markAsDrivingLicenseVerified()
                        state = .map
                    }
                    .navigationBarHidden(true)

                } label: {
                    EmptyView()
                }
                
                NavigationLink(tag: .map, selection: $state) {
                    MapCoordinatorView(errorHandler: appDependencies.errorHandler,
                                       scooterService: appDependencies.scooterService,
                                       rideService: appDependencies.rideService)
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
        MainCoordinatorView(appDependencies: .init())
    }
}
