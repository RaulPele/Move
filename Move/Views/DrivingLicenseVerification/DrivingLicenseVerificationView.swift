//
//  DrivingLicenseVerificationView.swift
//  Move
//
//  Created by Raul Pele on 29.08.2022.
//

import SwiftUI


class DrivingLicenseVerificationViewModel: ObservableObject {
    @Published var image: Image?
    @Published var showImagePicker = false
    @Published var showActionSheet = false
    @Published var showScanner = false
}

struct DrivingLicenseVerificationView: View {
    @ObservedObject var verificationViewModel: DrivingLicenseVerificationViewModel
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.neutralWhite
            ScrollView {
            VStack(spacing: 20) {
                HStack(spacing: 0) {
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
                
                Image("DrivingLicenseVerification")
                    .resizable()
                    .scaledToFill()
//                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 1/2)
//                    .clipped()
                
                VStack(alignment: .leading, spacing: 20) {
                    
                    Text("Before you can start\nriding")
                        .font(.heading1())
                        .foregroundColor(.primaryDark)

                    Text("Please take a photo or upload the front side of your driving license so we can make sure that it is valid.")
                    .font(.body1())
                    .foregroundColor(.primaryDark.opacity(0.7))

                }
                .padding(.horizontal, 24)
                
                Spacer()
                
                Button {
                    verificationViewModel.showActionSheet = true
                } label: {
                    Text("Add driving license")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.filledButton)
                .padding(.top, 31)
                .padding(.horizontal, 24)
                .sheet(isPresented: $verificationViewModel.showImagePicker) {
                    ImagePickerView(sourceType: .photoLibrary, image: $verificationViewModel.image, isPresented: $verificationViewModel.showImagePicker)
                }
                .sheet(isPresented: $verificationViewModel.showScanner) {
                    ScannerView { result in
                        verificationViewModel.showScanner = false
                    } didCancelScanning: {
                        verificationViewModel.showScanner = false
                    }

                }
                .actionSheet(isPresented: $verificationViewModel.showActionSheet) { () -> ActionSheet in
                        ActionSheet(title: Text("Choose uploading mode"), message:  Text("Please choose a way to upload a license picture"), buttons: [
                            ActionSheet.Button.default(Text("Camera"), action: {
                                self.verificationViewModel.showScanner = true
                            }),
                            ActionSheet.Button.default(Text("Gallery"), action: {
                                self.verificationViewModel.showImagePicker = true
                            })
                        ])
                }
                
            }
            .padding(.bottom, 20)
            }
        }
//        .edgesIgnoringSafeArea(.bottom)
    }
}

struct DrivingLicenseVerificationView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(devices) { device in
            DrivingLicenseVerificationView(verificationViewModel: .init())
                .previewDevice(device)
        }
        .previewInterfaceOrientation(.portrait)
        
    }
}
