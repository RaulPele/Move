//
//  AppCoordinatorView.swift
//  Move
//
//  Created by Raul Pele on 12.08.2022.
//

import SwiftUI

enum MainCoordinatorState {
    case start
    case onboarding
}

struct MainCoordinatorView: View {
    //@StateObject var coordinatorViewModel = MainCoordinatorViewModel(state: .start)
    @State var state: MainCoordinatorState? = MainCoordinatorState.start
    
    var body: some View {
        NavigationView {
            ZStack {
                NavigationLink(
                    destination: getSplashView()
                        .navigationBarBackButtonHidden(true),
                    tag: .start,
                    selection: $state) {
                        EmptyView()
                }
                .navigationBarHidden(true)

                NavigationLink(
                    destination: OnboardingCoordinatorView()
                        .navigationBarBackButtonHidden(true),
                    tag: .onboarding,
                    selection: $state) {
                        EmptyView()
                }
                .navigationBarHidden(true)
            }
        }
        .animation(.easeInOut, value: state)
        
    }
    
    func getSplashView() -> some View {
        return SplashView() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                state = .onboarding
            }
        }
    }
}

struct MainCoordinatorView_Previews: PreviewProvider {
    static var previews: some View {
        MainCoordinatorView()
    }
}
