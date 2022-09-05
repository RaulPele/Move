//
//  DrivingLicenseService.swift
//  Move
//
//  Created by Raul Pele on 31.08.2022.
//

import Foundation
import UIKit
import Alamofire

class DrivingLicenseAPIService: DrivingLicenseService {
    var url: URL
    
    init(url: String) {
        self.url = URL(string: url)!
    }
    
    func verifyLicense(image: UIImage, sessionToken: String,
                       completionHandler: @escaping (Result<User, Error>) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.85)else {
            return
        }
        print("JPEG Image: \(imageData)")
        
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(Data(sessionToken.utf8), withName: "token")
            multipartFormData.append(imageData, withName: "productImage", fileName: "license.jpeg", mimeType: "image/jpeg")
        }, to: url,
                  method: .put)
        .responseDecodable(of: VerificationResponse.self) { response in
            switch(response.result) {
            case .success(let verificationResponse):
                completionHandler(.success(verificationResponse.userDTO.toUser()))
            case .failure(let error):
                if let data = response.data,
                   let apiError = try? JSONDecoder().decode(APIError.self, from: data) {
                    completionHandler(.failure(apiError))
                } else {
                    completionHandler(.failure(error))
                }
            }
        }
    }
    
}

