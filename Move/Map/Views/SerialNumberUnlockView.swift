//
//  SerialNumberUnlockView.swift
//  Move
//
//  Created by Raul Pele on 16.09.2022.
//

import SwiftUI
import MapKit

struct SerialNumberUnlockView: View {
    let userLocation: CLLocation

    let onUnlockedSuccessfully: (Scooter) -> Void
    let onClose: () -> Void
    
    let errorHandler: ErrorHandler
    let scooterService: ScooterService
    
    @StateObject private var viewModel: SerialNumberUnlockViewModel
    
    init(errorHandler: ErrorHandler,
         scooterService: ScooterService,
         userLocation: CLLocation,
         onUnlockedSuccessfully: @escaping (Scooter) -> Void,
         onClose: @escaping () -> Void) {
        
        self.errorHandler = errorHandler
        self.scooterService = scooterService
        self.userLocation = userLocation
        self.onUnlockedSuccessfully = onUnlockedSuccessfully
        self.onClose = onClose
        self._viewModel = .init(wrappedValue: .init(scooterService: scooterService, userLocation: userLocation))
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
                                
                                viewModel.validatePin {
                                    viewModel.unlock { unlockedScooter in
                                        onUnlockedSuccessfully(unlockedScooter)
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
            SerialNumberUnlockView(errorHandler: SwiftMessagesErrorHandler(), scooterService: ScooterAPIService(sessionManager: .init()), userLocation: .init(), onUnlockedSuccessfully: { _ in }, onClose: {})
                .previewDevice(device)
        }
    }
}
