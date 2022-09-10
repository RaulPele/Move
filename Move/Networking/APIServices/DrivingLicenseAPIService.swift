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
    var url = URL(string: "https://move-scooters.herokuapp.com/api/users/addImage")!
    
//    init(url: String) {
//        self.url = URL(string: url)!
//    }
    
    func verifyLicense(image: UIImage, sessionToken: String,
                       completionHandler: @escaping (Result<User, Error>) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.85)else {
            return
        }
        
        let headers = ["Authorization": "Bearer \(sessionToken)"]
        
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imageData, withName: "productImage", fileName: "license.jpeg", mimeType: "image/jpeg")
        }, to: url,
                  method: .put, headers: .init(headers))
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

