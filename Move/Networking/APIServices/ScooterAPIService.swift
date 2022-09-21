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
    let baseURL = URL(string: "https://move-scooters.herokuapp.com")!
    
    func getAllScooters(completionHandler: @escaping (Result<[Scooter], Error>) -> Void) {
        let headers = ["Content-Type" : "application/json"]
        
        let request = AF.request(baseURL.appendingPathComponent("api/scooters/all"), method: .get, encoding: JSONEncoding.default, headers: .init(headers))
            
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
    
    func unlock(scooter: Scooter,
                userLocation: CLLocation,
                unlockMethod: UnlockMethod,
                sessionToken: String,
                completionHandler: @escaping (Result<Scooter, Error>) -> Void) {
        let parameters: [String : Any] = [
            "method" : unlockMethod.rawValue,
            "id" : scooter.scooterNumber,
            "latitude" : userLocation.coordinate.latitude,
            "longitude" : userLocation.coordinate.longitude
        ]
        
        let headers = ["Authorization" : "Bearer \(sessionToken)"]
        
        let request = AF.request(baseURL.appendingPathComponent("api/scooters/scan"),
                                 method: .patch,
                                 parameters: parameters,
                                 encoding: URLEncoding(destination: .queryString),
                                 headers: .init(headers))
        
        request
            .validate(statusCode: 200..<300)
            .responseDecodable(of: UnlockScooterResponse.self) { response in
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
}
