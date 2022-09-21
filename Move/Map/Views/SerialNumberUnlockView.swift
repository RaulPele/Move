//
//  SerialNumberUnlockView.swift
//  Move
//
//  Created by Raul Pele on 16.09.2022.
//

import SwiftUI
import MapKit

struct SerialNumberUnlockView: View {
    let scooter: Scooter
    let userLocation: CLLocation

    let onUnlockedSuccessfully: () -> Void
    let onClose: () -> Void
    
    let errorHandler: ErrorHandler
    let scooterService: ScooterService
    let sessionManager: SessionManager
    
    @StateObject private var viewModel: SerialNumberUnlockViewModel
    
    init(errorHandler: ErrorHandler,
         scooterService: ScooterService,
         sessionManager: SessionManager,
         scooter: Scooter,
         userLocation: CLLocation,
         onUnlockedSuccessfully: @escaping () -> Void,
         onClose: @escaping () -> Void) {
        self.errorHandler = errorHandler
        self.scooterService = scooterService
        self.sessionManager = sessionManager
        self.scooter = scooter
        self.userLocation = userLocation
        self.onUnlockedSuccessfully = onUnlockedSuccessfully
        self.onClose = onClose
        self._viewModel = .init(wrappedValue: .init(scooterService: scooterService, sessionManager: sessionManager, scooter: scooter, userLocation: userLocation))
    }
    
    
    var body: some View {
        ZStack(alignment: .top) {
            PurpleBackgroundView()
            
            GeometryReader { geo in
                ScrollView() {
                    VStack(spacing: 55) {
                        titleBarView
                        descriptionView
                        
                        Spacer()
                        
                        PinTextField(pinCode: $viewModel.text, numberOfDigits: 4)
                            .onChange(of: viewModel.text) { newValue in
                                print(viewModel.text)
                                viewModel.validatePin {
                                    viewModel.unlock {
                                        onUnlockedSuccessfully()
                                    } onError: { error in
                                        errorHandler.handle(error: error, title: "Cannot unlock scooter!")
                                    }
                                    
                                } onError: {
                                    print("Invalid Pin")
                                }
                                
                            }
                            .overlay(ActivityIndicator(isVisible: $viewModel.isLoading, color: .accentColor)
                                .frame(width: 100, height: 100))
                        
                        Spacer()
                        Spacer()
                        
                        Text("Alternatively you can unlock using")
                            .font(.body1())
                            .foregroundColor(.neutralWhite)
                        //                            .frame(maxHeight:.infinity, alignment: .bottom)
                            .padding(.bottom, 100)
                    }
                    .padding(.horizontal, 24)
                    .frame(minHeight: geo.size.height)
                }
            }
        }
    }
}

private extension SerialNumberUnlockView {
    var titleBarView: some View {
        return HStack(spacing: 0) {
            Button {
                onClose()
            } label: {
                Image("close-icon")
            }
            
            Spacer()
            Text("Enter serial number")
                .font(.heading3())
                .foregroundColor(.neutralWhite)
            Spacer()
        }
        
    }
    
    var descriptionView: some View {
        VStack(spacing: 16) {
            Text("Enter the scooter's serial number")
                .font(.heading1())
                .foregroundColor(.neutralWhite)
                .multilineTextAlignment(.center)
            
            Text("You can find it on the scooter's front panel")
                .font(.body1())
                .foregroundColor(.neutralWhite.opacity(0.6))
                .multilineTextAlignment(.center)
        }
    }
}

struct SerialNumberUnlockView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(devices) { device in
            SerialNumberUnlockView(errorHandler: SwiftMessagesErrorHandler(), scooterService: ScooterAPIService(), sessionManager: SessionManager(), scooter: .init(id: "1234", scooterNumber: 1234, bookedStatus: .free, lockedStatus: .available, batteryPercentage: 100, location: .init()), userLocation: .init(), onUnlockedSuccessfully: {}, onClose: {})
                .previewDevice(device)
        }
    }
}
