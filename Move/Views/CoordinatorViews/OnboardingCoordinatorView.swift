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
                NavigationLink(tag: .safety, selection: $coordinatorViewModel.state) {
                    OnboardingView(onboardingData: .safety(),
                                   pageIndex: 0,
                                   numberOfPages: coordinatorViewModel.numberOfPages) {
                        coordinatorViewModel.state = .scan
                    }
                    .navigationBarBackButtonHidden(true)
                } label: {
                    EmptyView()
                }
//                .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                
                NavigationLink(tag: .scan, selection: $coordinatorViewModel.state) {
                    OnboardingView(onboardingData: .scan(),
                                   pageIndex: 1,
                                   numberOfPages: coordinatorViewModel.numberOfPages) {
                        coordinatorViewModel.state = .ride
                    }
                    .navigationBarBackButtonHidden(true)
                } label: {
                    EmptyView()
                }

                NavigationLink(tag: .ride, selection: $coordinatorViewModel.state) {
                    OnboardingView(onboardingData: .ride(),
                                   pageIndex: 2,
                                   numberOfPages: coordinatorViewModel.numberOfPages) {
                        coordinatorViewModel.state = .parking
                    }
                    .navigationBarBackButtonHidden(true)
                    
                } label: {
                    EmptyView()
                }
                
                NavigationLink(tag: .parking, selection: $coordinatorViewModel.state) {
                    OnboardingView(onboardingData: .parking(),
                                   pageIndex: 3,
                                   numberOfPages: coordinatorViewModel.numberOfPages) {
                        coordinatorViewModel.state = .rules
                    }
                    .navigationBarBackButtonHidden(true)
                    
                } label: {
                    EmptyView()
                }

                NavigationLink(tag: .rules, selection: $coordinatorViewModel.state) {
                    OnboardingView(onboardingData: .rules(),
                                   pageIndex: 4,
                                   numberOfPages: coordinatorViewModel.numberOfPages) {
                        coordinatorViewModel.state = .safety
                    }
                    .navigationBarBackButtonHidden(true)
                    
                } label: {
                    EmptyView()
                }
            }
            .animation(.easeInOut, value: coordinatorViewModel.state)
        }

    }
}

struct OnboardingCoordinatorView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingCoordinatorView(coordinatorViewModel: .init(state: .safety))
    }
}
