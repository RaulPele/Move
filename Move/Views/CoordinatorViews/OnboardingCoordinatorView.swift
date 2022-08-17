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
        NavigationView {
            ZStack {
                ForEach(Array(OnboardingCoordinatorState.allCases.enumerated()), id: \.offset) { index, state in
                    NavigationLink(tag: state, selection: $coordinatorViewModel.state) {
                        OnboardingView(onboardingData:
                                        coordinatorViewModel.getDataForCurrentState(state),
                                       pageIndex: index,
                                       numberOfPages: coordinatorViewModel.numberOfPages) {
                            coordinatorViewModel.state = coordinatorViewModel.getNextState(currentState: state)
                        }
                        .navigationBarHidden(true)
                        .transition(.opacity.animation(.default))

                    } label: {
                        EmptyView()
                    }
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
