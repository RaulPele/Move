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
        
        let drivingLicenseService: DrivingLicenseService = DrivingLicenseAPIService(url: "https://move-scooters.herokuapp.com/users/login")
        
        func verifyLicense(completionHandler: @escaping (Result<User, Error>) -> Void) {
            //TODO: Session service
            guard let image = image else {
                return
            }

            let userData = UserDefaults.standard.data(forKey: "userData")!
            let authenticationData = try! JSONDecoder().decode(AuthenticationResponse.self, from: userData)
            print("token: \(authenticationData.token)")
            drivingLicenseService.verifyLicense(image: image, sessionToken: authenticationData.token, completionHandler: completionHandler)
        }
    }
}