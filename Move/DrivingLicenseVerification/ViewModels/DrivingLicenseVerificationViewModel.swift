//
//  DrivingLicenseVerificationViewModel.swift
//  Move
//
//  Created by Raul Pele on 31.08.2022.
//

import Foundation
import SwiftUI

extension DrivingLicenseVerificationView {
    class DrivingLicenseVerificationViewModel: ObservableObject {
        @Published var image: UIImage?
        @Published var showImagePicker = false
        @Published var showActionSheet = false
        @Published var showScanner = false
        
        private let drivingLicenseService: DrivingLicenseService
        
        init(drivingLicenseService: DrivingLicenseService) {
            self.drivingLicenseService = drivingLicenseService
        }
        
        func verifyLicense(onVerificationFinished: @escaping () -> Void, onError: @escaping (Error) -> Void) {
            //TODO: Session service

            guard let image = image else { return }
            
            drivingLicenseService.verifyLicense(image: image) { result in
            switch result {
                case .success(_):
                    onVerificationFinished()
                case .failure(let error):
                    onError(error)
                }
            }
        }
    }
}
