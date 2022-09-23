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
    private let url = URL(string: "https://move-scooters.herokuapp.com/api/users/addImage")!
    private let sessionManager: SessionManager
    
    init(sessionManager: SessionManager) {
        self.sessionManager = sessionManager
    }
    
    func verifyLicense(image: UIImage,
                       completionHandler: @escaping (Result<User, Error>) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.85),
            let sessionToken = sessionManager.getSessionToken() else {
            return
        }
        
        let headers = ["Authorization": "Bearer \(sessionToken)"]
        
        let request = AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imageData, withName: "productImage", fileName: "license.jpeg", mimeType: "image/jpeg")
        }, to: url,
                  method: .put, headers: .init(headers))
        
        request
            .validate(statusCode: 200..<300)
        .responseDecodable(of: VerificationResponse.self) { response in
            switch(response.result) {
            case .success(let verificationResponse):
                print("SUCCESS")
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

