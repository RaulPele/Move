//
//  ScooterAPIService.swift
//  Move
//
//  Created by Raul Pele on 06.09.2022.
//

import Foundation
import Alamofire
import MapKit

class ScooterAPIService: ScooterService {
    private let apiConfig: APIConfig = .init(baseUrlString: "https://move-scooters.herokuapp.com/api")
    private let sessionManager: SessionManager
    
    init(sessionManager: SessionManager) {
        self.sessionManager = sessionManager
    }
    
    func getAllScooters(completionHandler: @escaping (Result<[Scooter], Error>) -> Void) {
        guard let sessionToken = sessionManager.getSessionToken() else {
            return
        }
        
        let headers = [
            "Content-Type" : "application/json",
            "Authorization" : "Bearer \(sessionToken)"
        ]
        
        let request = AF.request(apiConfig.getUrl(for: .getAllScooters), method: .get, encoding: JSONEncoding.default, headers: .init(headers))
            
        request.validate(statusCode: 200..<300)
            .responseDecodable(of: GetScootersResponse.self) { response in
                switch response.result {
                case .success(let getScootersResponse):
                    completionHandler(.success(getScootersResponse.scooters.toScooterArray()))
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
    
    func unlock(scooterPin: Int,
                userLocation: CLLocation,
                unlockMethod: UnlockMethod,
                completionHandler: @escaping (Result<Scooter, Error>) -> Void) {
        guard let sessionToken = sessionManager.getSessionToken() else {
            return
        }
        
        let parameters: [String : Any] = [
            "method" : unlockMethod.rawValue,
            "id" : scooterPin,
            "latitude" : userLocation.coordinate.latitude,
            "longitude" : userLocation.coordinate.longitude
        ]
        let headers = ["Authorization" : "Bearer \(sessionToken)"]
        
        let request = AF.request(apiConfig.getUrl(for: .scanScooter),
                                 method: .patch,
                                 parameters: parameters,
                                 encoding: URLEncoding(destination: .queryString),
                                 headers: .init(headers))
        
        request
            .validate(statusCode: 200..<300)
            .responseDecodable(of: ScooterInteractionResponse.self) { response in
                switch response.result {
                case .success(let unlockScooterResponse):
                    completionHandler(.success(unlockScooterResponse.scooterDTO.toScooter()))
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
    
    func cancelScan(scooterPin: Int, completionHandler: @escaping (Result<Scooter, Error>) -> Void) {
        guard let sessionToken = sessionManager.getSessionToken() else {
            return
        }
        
        let headers = ["Authorization" : "Bearer \(sessionToken)"]
        let parameters: [String: Any] = [
            "id" : scooterPin
        ]
        
        let request = AF.request(apiConfig.getUrl(for: .cancelScan),
                                 method: .patch,
                                 parameters: parameters,
                                 encoding: URLEncoding(destination: .queryString),
                                 headers: .init(headers))
        
        request
            .validate(statusCode: 200..<300)
            .responseDecodable(of: ScooterInteractionResponse.self) { response in
                switch response.result {
                case .success(let cancelScanResponse):
                    completionHandler(.success(cancelScanResponse.scooterDTO.toScooter()))
                    
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
