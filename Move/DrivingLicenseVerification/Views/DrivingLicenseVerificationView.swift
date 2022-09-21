//
//  DrivingLicenseVerificationView.swift
//  Move
//
//  Created by Raul Pele on 29.08.2022.
//

import SwiftUI

struct DrivingLicenseVerificationView: View {
    var errorHandler: ErrorHandler
    let drivingLicenseService: DrivingLicenseService
    let sessionManager: SessionManager
    
    @StateObject private var verificationViewModel: DrivingLicenseVerificationViewModel
    
    let onVerificationPending: () -> Void
    let onVerificationFinished: () -> Void
    let onBackButtonPressed: () -> Void
    
    init(errorHandler: ErrorHandler,
         drivingLicenseService: DrivingLicenseService,
         sessionManager: SessionManager,
         onVerificationPending: @escaping () -> Void,
         onVerificationFinished: @escaping () -> Void,
         onBackButtonPressed: @escaping () -> Void) {
        self.errorHandler = errorHandler
        self.drivingLicenseService = drivingLicenseService
        self.sessionManager = sessionManager
        self.onVerificationPending = onVerificationPending
        self.onVerificationFinished = onVerificationFinished
        self.onBackButtonPressed = onBackButtonPressed
        
        self._verificationViewModel = StateObject(wrappedValue: DrivingLicenseVerificationViewModel(drivingLicenseService: drivingLicenseService, sessionManager: sessionManager))
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.neutralWhite
            
            VStack(spacing: 20) {
                titleBar
                
                Color.clear
                    .overlay(alignment: .top) {
                        Image("DrivingLicenseVerification")
                            .resizable()
                            .scaledToFill()
                    }
                    .clipped()
                    .layoutPriority(2)
                
                descriptionView
                Spacer()
                addLicenseButton
        
            }
        }
    }
}

private extension DrivingLicenseVerificationView {
    var titleBar: some View {
        return HStack(spacing: 0) {
            Button {
                onBackButtonPressed()
            } label: {
                Image("chevron-left")
            }
            
            Spacer()
            
            Text("Driving License")
                .font(.heading3())
                .foregroundColor(.primaryDark)
            
            Spacer()
        }
        .padding(.horizontal, 24)
    }
    
    var descriptionView: some View {
        return VStack(alignment: .leading, spacing: 20) {
            Text("Before you can start riding")
                .font(.heading1())
                .foregroundColor(.primaryDark)
                .lineLimit(2)
                .fixedSize(horizontal: false, vertical: true)
            
            Text("Please take a photo or upload the front side of your driving license so we can make sure that it is valid.")
                .font(.body1())
                .foregroundColor(.primaryDark.opacity(0.7))
                .lineLimit(3)
                .fixedSize(horizontal: false, vertical: true)
            
        }
        .padding(.horizontal, 24)
    }
    
    var addLicenseButton: some View {
        return Button {
            verificationViewModel.showActionSheet = true
            
        } label: {
            Text("Add driving license")
                .frame(maxWidth: .infinity)
        }
        .buttonStyle(.filledButton)
        .padding(.horizontal, 24)
        .sheet(isPresented: $verificationViewModel.showImagePicker) {
            ImagePickerView(sourceType: .photoLibrary, image: $verificationViewModel.image, isPresented: $verificationViewModel.showImagePicker)
        }
        .sheet(isPresented: $verificationViewModel.showScanner) {
            ScannerView(image: $verificationViewModel.image) {
                verificationViewModel.showScanner = false
            } onScanError: { error in
                print("Error")
            }
        }
        .actionSheet(isPresented: $verificationViewModel.showActionSheet) { () -> ActionSheet in
            ActionSheet(title: Text("Choose uploading mode"), message:  Text("Please choose a way to upload a license picture"), buttons: [
                ActionSheet.Button.default(
                    Text("Camera").foregroundColor(.primaryDark), action: {
                        self.verificationViewModel.showScanner = true
                    }),
                ActionSheet.Button.default(Text("Gallery"), action: {
                    self.verificationViewModel.showImagePicker = true
                }),
                ActionSheet.Button.default(Text("Cancel"), action: {
                    self.verificationViewModel.showActionSheet = false
                })
            ])
        }
        .onChange(of: verificationViewModel.image) { _ in
            verificationViewModel.verifyLicense {
                onVerificationFinished()
            } onError: { error in
                errorHandler.handle(error: error, title: "License verification failed")
            }
            onVerificationPending()
        }
        .padding(.bottom, 20)
        .padding(.top, 10)
    }
}

struct DrivingLicenseVerificationView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(devices) { device in
            DrivingLicenseVerificationView(errorHandler: SwiftMessagesErrorHandler(), drivingLicenseService: DrivingLicenseAPIService(), sessionManager: SessionManager(), onVerificationPending: {}, onVerificationFinished: {}, onBackButtonPressed: {})
                .previewDevice(device)
        }
        .previewInterfaceOrientation(.portrait)
    }
}
