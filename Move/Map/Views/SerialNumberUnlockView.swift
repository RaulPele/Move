//
//  SerialNumberUnlockView.swift
//  Move
//
//  Created by Raul Pele on 16.09.2022.
//

import SwiftUI

struct SerialNumberUnlockView: View {
    let scooter: Scooter
    let onUnlockedSuccessfully: () -> Void
    @StateObject private var viewModel: SerialNumberUnlockViewModel
    
    init(scooter: Scooter, onUnlockedSuccessfully: @escaping () -> Void) {
        self.scooter = scooter
        self.onUnlockedSuccessfully = onUnlockedSuccessfully
        self._viewModel = .init(wrappedValue: .init(scooter: scooter))
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
                                    viewModel.unlock {
                                        onUnlockedSuccessfully()
                                    } onError: { error in
                                        print("error while unlocking")
                                    }

                                } onError: {
                                    print("Invalid Pin")
                                }

                            }
                            .overlay(ActivityIndicator(isVisible: $viewModel.isLoading, color: .accentColor)
                                .frame(width: 100, height: 100))
                        
                            Spacer()
                            Spacer()
//                        .overlay(ActivityIndicator(isVisible: .constant(true))
//                            .frame(width: 100, height: 100))
                        
                            
                        
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
            Image("close-icon")
                
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
            SerialNumberUnlockView( scooter: .init(id: "123", scooterNumber: 1234, bookedStatus: .free, lockedStatus: .available, batteryPercentage: 65, location: .init()), onUnlockedSuccessfully: {})
                .previewDevice(device)
        }
    }
}
