//
//  DrivingLicenseService.swift
//  Move
//
//  Created by Raul Pele on 05.09.2022.
//

import Foundation
import SwiftUI

protocol DrivingLicenseService {
    func verifyLicense(image: UIImage, sessionToken: String, completionHandler: @escaping (Result<User, Error>) -> Void)
}
