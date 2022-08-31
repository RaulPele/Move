//
//  DrivingLicenseVerificationViewModel.swift
//  Move
//
//  Created by Raul Pele on 31.08.2022.
//

import Foundation
import SwiftUI

class DrivingLicenseVerificationViewModel: ObservableObject {
    @Published var image: Image?
    @Published var showImagePicker = false
    @Published var showActionSheet = false
    @Published var showScanner = false
    
    func verifyLicense(image: UIImage) {
        //TODO: verify license
    }
}
