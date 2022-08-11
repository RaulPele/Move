//
//  OnboardingCoordinatorView.swift
//  Move
//
//  Created by Raul Pele on 11.08.2022.
//

import SwiftUI

enum OnboardingCoordinatorState {
    case safety
    case scan
    case ride
    case parking
    case rules
}

class OnboardingCoordinatorViewModel: ObservableObject {
    @Published var state: OnboardingCoordinatorState
    
    init(state: OnboardingCoordinatorState) {
        self.state = state
    }
}

struct OnboardingCoordinatorView: View {
    @StateObject var coordinatorViewModel = OnboardingCoordinatorViewModel(state: .safety)
    
    var body: some View {
        ZStack {
            switch coordinatorViewModel.state {
            case .safety:
                OnboardingView(onboardingData: .safety()) {
                    coordinatorViewModel.state = .scan
                }
            case .scan:
                OnboardingView(onboardingData: .scan()) {
                    coordinatorViewModel.state = .ride
                }
            case .ride:
                OnboardingView(onboardingData: .ride()) {
                    coordinatorViewModel.state = .parking
                }

            case .parking:
                OnboardingView(onboardingData: .parking()) {
                    coordinatorViewModel.state = .rules
                }

            case .rules:
                OnboardingView(onboardingData: .rules()) {
                    coordinatorViewModel.state = .scan //modify
                }
            }
        }
    }
}

struct OnboardingCoordinatorView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingCoordinatorView(coordinatorViewModel: .init(state: .safety))
    }
}
