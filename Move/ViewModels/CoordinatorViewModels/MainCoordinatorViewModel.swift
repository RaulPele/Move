//
//  AppCoordinatorViewModel.swift
//  Move
//
//  Created by Raul Pele on 12.08.2022.
//

import Foundation

class MainCoordinatorViewModel: ObservableObject {
    @Published var state: MainCoordinatorState?
    
    init(state: MainCoordinatorState) {
        self.state = state
    }
}
