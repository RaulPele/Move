//
//  OnboardingCoordinatorView.swift
//  Move
//
//  Created by Raul Pele on 11.08.2022.
//

import SwiftUI

struct OnboardingCoordinatorView: View {
    @StateObject var coordinatorViewModel = OnboardingCoordinatorViewModel(state: .safety)
    
    var body: some View {
        ZStack {
            switch coordinatorViewModel.state {
            case .safety:
                OnboardingView(onboardingData: .safety(), pageIndex: 0, numberOfPages: coordinatorViewModel.numberOfPages) {
                    coordinatorViewModel.state = .scan
                   
                }
                .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                
            case .scan:
                OnboardingView(onboardingData: .scan(), pageIndex: 1, numberOfPages: coordinatorViewModel.numberOfPages) {
                    coordinatorViewModel.state = .ride
                }
                .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                
            case .ride:
                OnboardingView(onboardingData: .ride(), pageIndex: 2, numberOfPages: coordinatorViewModel.numberOfPages) {
                    coordinatorViewModel.state = .parking
                }
                .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                
            case .parking:
                OnboardingView(onboardingData: .parking(), pageIndex: 3, numberOfPages: coordinatorViewModel.numberOfPages) {
                    coordinatorViewModel.state = .rules
                }
                .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))

            case .rules:
                OnboardingView(onboardingData: .rules(), pageIndex: 4, numberOfPages: coordinatorViewModel.numberOfPages) {
                    coordinatorViewModel.state = .safety //modify
                }
                .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
            }
        }
        .animation(.easeInOut, value: coordinatorViewModel.state)

    }
}

struct OnboardingCoordinatorView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingCoordinatorView(coordinatorViewModel: .init(state: .safety))
    }
}
