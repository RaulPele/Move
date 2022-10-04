//
//  MenuView.swift
//  Move
//
//  Created by Raul Pele on 03.10.2022.
//

import SwiftUI

struct MenuView: View {
    let errorHandler: ErrorHandler
    let userService: UserService
    let authenticationService: AuthenticationService
    let onBackButtonClicked: () -> Void
    let onSeeHistory: () -> Void
    let onLogout: () -> Void
    
    @StateObject private var viewModel: ViewModel
    
    init(errorHandler: ErrorHandler,
         userService: UserService,
         authenticationService: AuthenticationService,
         onBackButtonClicked: @escaping () -> Void,
         onSeeHistory: @escaping () -> Void,
         onLogout: @escaping () -> Void) {
        self.errorHandler = errorHandler
        self.userService = userService
        self.authenticationService = authenticationService
        self.onBackButtonClicked = onBackButtonClicked
        self.onSeeHistory = onSeeHistory
        self.onLogout = onLogout
        
        self._viewModel = .init(wrappedValue: .init(userService: userService, authenticationService: authenticationService))
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.neutralWhite
                .ignoresSafeArea()
            
            VStack(spacing: 32) {
                titleBarView
                    .padding(.bottom, 20)
                historyHeaderView
                menuSectionsView
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .background(alignment: .bottomTrailing) {
                Image("MenuScooter")
                    .resizable()
                    .scaledToFit()
            }

            .padding(.horizontal, 24)
            .padding(.vertical, 10)

            
        }
        .onAppear {
            viewModel.getUserDetails { error in
                errorHandler.handle(error: error, title: "Couldn't get user details!")
            }
        }
    }
}

private extension MenuView {
    var titleBarView: some View {
        HStack(spacing: 0) {
            Button {
                onBackButtonClicked()
            } label: {
                Image("chevron-left")
            }
            
            Spacer()
            
            Text("Hi \(viewModel.user?.username ?? "")!")
                .foregroundColor(.primaryDark)
                .font(.heading3())
            
            Spacer()
            logoutView
        }
    }
    
    var historyHeaderView: some View {
        HStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 0) {
                Text("History")
                    .foregroundColor(.white)
                    .font(.button1())
                    .padding(.vertical, 2)
                
                Text("Total rides: \(viewModel.numberOfTrips)")
                    .foregroundColor(.neutralLightPurple)
                    .font(.heading4())
                    .padding(.vertical, 2)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Button {
                onSeeHistory()
            } label: {
                HStack(spacing: 0) {
                    Text("See all")
                    Image("chevron-right")
                }
                .frame(maxWidth: .infinity)
            }
            .buttonStyle(.filledButton)
        }
        .frame(maxWidth: .infinity)
        .padding(32)
        .background(RoundedRectangle(cornerRadius: 29)
            .foregroundColor(.primaryLight)
            .overlay(alignment: .leading) {
                Image("SheetScooterRectangleBackground")
                    .rotationEffect(.degrees(45))
                    .offset(x: -8, y: -15)
            }
            .clipped())
        
    }
    
    var generalSettingsView: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 16) {
                Image("settings-icon")
                Text("General Settings")
                    .foregroundColor(.primaryDark)
                    .font(.button1())
            }
            .padding(.bottom, 16)
            
            Group {
                Button {
                    
                } label: {
                    Text("Account")
                        .foregroundColor(.primaryDark)
                        .font(.button2())
                        .padding(.vertical, 20)
                }
                
                Button {
                    
                } label: {
                    Text("Change password")
                        .foregroundColor(.primaryDark)
                        .font(.button2())
                        .padding(.vertical, 20)
                }
            }
            .padding(.leading, 40)
        }
    }
    
    var legalConditionsView: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 16) {
                Image("flag-icon")
                Text("Legal")
                    .foregroundColor(.primaryDark)
                    .font(.button1())
            }
            .padding(.bottom, 16)
            
            Group {
                Button {
                    
                } label: {
                    Text("Terms and conditions")
                        .foregroundColor(.primaryDark)
                        .font(.button2())
                        .padding(.vertical, 20)
                }
                
                Button {
                    
                } label: {
                    Text("Privacy policy")
                        .foregroundColor(.primaryDark)
                        .font(.button2())
                        .padding(.vertical, 20)
                }
            }
            .padding(.leading, 40)
        }
    }
    
    var rateUsView: some View {
        HStack(spacing: 16) {
            Image("star-icon")
            Text("Rate us")
                .foregroundColor(.primaryDark)
                .font(.button1())
        }
    }
    
    var logoutView: some View {
        Button {
            viewModel.logout {
                onLogout()
            }
        } label: {
            Text("Log out")
                .foregroundColor(.accentColor)
                .font(.button1())
        }
    }
    
    var menuSectionsView: some View {
        VStack(alignment: .leading,spacing: 0) {
            generalSettingsView
                .padding(.bottom, 24)
            legalConditionsView
                .padding(.bottom, 24)
            rateUsView
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(devices) { device in
            MenuView(errorHandler: SwiftMessagesErrorHandler(), userService: UserAPIService(sessionManager: .init()), authenticationService: AuthenticationAPIService(sessionManager: .init()), onBackButtonClicked: {}, onSeeHistory: {}, onLogout: {
                
            })
                .previewDevice(device)
        }
    }
}
