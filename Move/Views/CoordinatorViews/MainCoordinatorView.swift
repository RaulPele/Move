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
    @State var state: MainCoordinatorState? = MainCoordinatorState.start
    
    var body: some View {
        NavigationView {
            ZStack {
                NavigationLink(
                    destination: getSplashView()
                        .navigationBarHidden(true),

                    tag: .start,
                    selection: $state) {
                        EmptyView()
                }

                NavigationLink(
                    destination: OnboardingCoordinatorView()
                        .navigationBarHidden(true),
                    tag: .onboarding,
                    selection: $state) {
                        EmptyView()
                }
            }
        }
//        .animation(.easeInOut, value: state)
        
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
