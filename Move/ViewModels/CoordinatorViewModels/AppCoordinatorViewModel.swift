//
//  AppCoordinatorViewModel.swift
//  Move
//
//  Created by Raul Pele on 12.08.2022.
//

import Foundation

enum AppCoordinatorState {
    case start
    case onboarding
}

class AppCoordinatorViewModel: ObservableObject {
    @Published var state: AppCoordinatorState
    
    init(state: AppCoordinatorState) {
        self.state = state
    }
}
