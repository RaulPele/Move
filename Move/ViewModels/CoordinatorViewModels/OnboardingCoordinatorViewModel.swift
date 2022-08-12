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

class OnboardingCoordinatorViewModel: ObservableObject {
    @Published var state: OnboardingCoordinatorState
    var numberOfPages: Int {
        return OnboardingCoordinatorState.allCases.count
    }
    
    init(state: OnboardingCoordinatorState) {
        self.state = state
    }
}
