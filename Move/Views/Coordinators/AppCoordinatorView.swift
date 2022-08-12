//
//  AppCoordinatorView.swift
//  Move
//
//  Created by Raul Pele on 12.08.2022.
//

import SwiftUI

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

struct AppCoordinatorView: View {
    @StateObject var coordinatorViewModel = AppCoordinatorViewModel(state: .start)
    
    var body: some View {
        ZStack {
            switch coordinatorViewModel.state {
            case .start:
                SplashView()
                    .onAppear() {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            coordinatorViewModel.state  = .onboarding
                        }
                    }
                
                
            case .onboarding:
                OnboardingCoordinatorView()
            }
        }
        .animation(.easeInOut, value: coordinatorViewModel.state)
        
    }
}

struct AppCoordinatorView_Previews: PreviewProvider {
    static var previews: some View {
        AppCoordinatorView()
    }
}
