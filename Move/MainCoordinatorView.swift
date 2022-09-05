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
    let errorHandler: MyErrorHandler
    
    @State private var state: MainCoordinatorState? = MainCoordinatorState.start
    @StateObject private var errorToastViewModel: ErrorToastViewModel
    
    init(errorHandler: MyErrorHandler) {
        self.errorHandler = errorHandler
        self._errorToastViewModel = StateObject(wrappedValue: errorHandler.viewModel)
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
                    AuthenticationCoordinatorView {
                        state = .drivingLicenseVerification
                    } onRegisterCompleted: {
                        state = .drivingLicenseVerification
                    }
                    .navigationBarHidden(true)
                    .overlay(errorView)

                } label: {
                    EmptyView()
                }
                
                NavigationLink(tag: .drivingLicenseVerification, selection: $state) {
                    DrivingLicenseVerificationCoordinatorView {
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
    
    @ViewBuilder
    var errorView: some View {
        if let error = errorToastViewModel.error {
            Text(error.title)
                .foregroundColor(.white)
                .background(.red)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        }
    }
}

struct MainCoordinatorView_Previews: PreviewProvider {
    static var previews: some View {
        MainCoordinatorView(errorHandler: .shared)
    }
}
