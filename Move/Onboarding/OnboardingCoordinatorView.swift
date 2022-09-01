//
//  OnboardingCoordinatorView.swift
//  Move
//
//  Created by Raul Pele on 11.08.2022.
//

import SwiftUI

struct OnboardingCoordinatorView: View {
    @StateObject private var coordinatorViewModel = OnboardingCoordinatorViewModel(state: .safety)
    let onFinished : () -> Void
    
    var body: some View {
        NavigationView {
            ZStack {
                ForEach(Array(OnboardingCoordinatorState.allCases.enumerated()), id: \.offset) { index, state in
                    NavigationLink(tag: state, selection: $coordinatorViewModel.state) {
                        OnboardingView(onboardingData:
                                        coordinatorViewModel.getDataForCurrentState(state),
                                       pageIndex: index,
                                       numberOfPages: coordinatorViewModel.numberOfPages,
                                       onNextButtonClicked: index == coordinatorViewModel.numberOfPages - 1 ? onFinished : {
                            coordinatorViewModel.state = coordinatorViewModel.getNextState(currentState: state)
                        }, onSkipButtonClicked: {
                            onFinished()
                        })
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
        OnboardingCoordinatorView {}
    }
}
