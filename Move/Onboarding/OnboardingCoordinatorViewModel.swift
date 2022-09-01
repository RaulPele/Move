//
//  OnboardingCoordinatorViewModel.swift
//  Move
//
//  Created by Raul Pele on 12.08.2022.
//

import Foundation

enum OnboardingCoordinatorState: CaseIterable {
    case safety
    case scan
    case ride
    case parking
    case rules
}
extension OnboardingCoordinatorView {
    class OnboardingCoordinatorViewModel: ObservableObject {
        @Published var state: OnboardingCoordinatorState?
        
        var numberOfPages: Int {
            return OnboardingCoordinatorState.allCases.count
        }
        
        init(state: OnboardingCoordinatorState) {
            self.state = state
        }
        
        func getDataForCurrentState(_ state: OnboardingCoordinatorState) -> OnboardingData {
            switch state {
            case .safety:
                return .safety()
            case .scan:
                return .scan()
            case .ride:
                return .ride()
            case .parking:
                return .parking()
            case .rules:
                return .rules()
            }
        }
        
        func getNextState(currentState: OnboardingCoordinatorState) -> OnboardingCoordinatorState {
            switch currentState {
            case .safety:
                return .scan
            case .scan:
                return .ride
            case .ride:
                return .parking
            case .parking:
                return .rules
            case .rules:
                return .scan
            }
        }
    }
}
