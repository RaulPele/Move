//
//  DrivingLicenseService.swift
//  Move
//
//  Created by Raul Pele on 31.08.2022.
//

import Foundation
import UIKit
import Alamofire

protocol DrivingLicenseService {
    func verifyLicense(image: UIImage)
}

class DrivingLicenseAPIService: DrivingLicenseService {
    var url: URL
    
    init(url: String) {
        self.url = URL(string: url)!
    }
    
    func verifyLicense(image: UIImage) {
        guard let jpegImage = image.jpegData(compressionQuality: 1) else {
            return
        }
        let headers = ["Content-Type": "image/jpeg"]
        
//        let request = AF.upload(jpegImage, to: url, method: .put, headers: HTTPHeaders(headers))
//        request
//            .validate(statusCode: 200..<300)
        print("JPEG Image: \(jpegImage)")
    }

}

