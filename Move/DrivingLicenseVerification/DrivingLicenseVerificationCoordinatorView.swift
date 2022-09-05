//
//  DrivingLicenseVerificationCoordinatorView.swift
//  Move
//
//  Created by Raul Pele on 05.09.2022.
//

import SwiftUI

enum DrivingLicenseVerificationCoordinatorState {
    case verification
    case pending
    case valid
}

struct DrivingLicenseVerificationCoordinatorView: View {
    @State private var state: DrivingLicenseVerificationCoordinatorState? = .verification
    let onBackButtonPressed: () -> Void
    let onVerificationFinished: () -> Void
    
    var body: some View {
        NavigationView {
            ZStack {
                NavigationLink(tag: .verification, selection: $state) {
                    DrivingLicenseVerificationView(onVerificationPending: {
                        state = .pending
                    }, onVerificationFinished: {
                        state = .valid
                    }, onBackButtonPressed: {
                        onBackButtonPressed()
                    })
                    .navigationBarHidden(true)
                } label: {
                    EmptyView()
                }
                
                NavigationLink(tag: .pending, selection: $state) {
                    DrivingLicensePendingVerificationView()
                        .navigationBarHidden(true)
                    
                } label: {
                    EmptyView()
                }
                
                NavigationLink(tag: .valid, selection: $state) {
                    ValidLicenseView()
                        .navigationBarHidden(true)
                        .onAppear() {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                onVerificationFinished()
                            }
                        }
                    
                } label: {
                    EmptyView()
                }
            }
        }
    }
}

struct DrivingLicenseVerificationCoordinatorView_Previews: PreviewProvider {
    static var previews: some View {
        DrivingLicenseVerificationCoordinatorView(onBackButtonPressed: {}, onVerificationFinished: {})
    }
}
