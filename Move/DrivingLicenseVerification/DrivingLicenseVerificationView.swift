//
//  DrivingLicenseVerificationView.swift
//  Move
//
//  Created by Raul Pele on 29.08.2022.
//

import SwiftUI

struct DrivingLicenseVerificationView: View {
    @StateObject private var verificationViewModel = DrivingLicenseVerificationViewModel()
    
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
                
                Button {
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
                    ScannerView { result in
                        verificationViewModel.showScanner = false
                        switch result {
                        case .success(let scannedImages):
                            verificationViewModel.verifyLicense(image: scannedImages[0])
                        case .failure(let error) :
                            print("Scanning error: \(error.localizedDescription)")
                        }
                    } didCancelScanning: {
                        verificationViewModel.showScanner = false
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
                
            }
            .padding(.bottom, 20)
            .padding(.top, 10)
        }
    }
}

private extension DrivingLicenseVerificationView {
    var titleBar: some View {
        return HStack(spacing: 0) {
            Button {
                
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
}

struct DrivingLicenseVerificationView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(devices) { device in
            DrivingLicenseVerificationView()
                .previewDevice(device)
        }
        .previewInterfaceOrientation(.portrait)
    }
}
