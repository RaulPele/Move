//
//  ScooterAPIService.swift
//  Move
//
//  Created by Raul Pele on 06.09.2022.
//

import Foundation
import Alamofire

class ScooterAPIService: ScooterService {
    let baseURL = URL(string: "https://move-scooters.herokuapp.com")!
    
    func getAllScooters(completionHandler: @escaping (Result<[Scooter], Error>) -> Void) {
        let headers = ["Content-Type" : "application/json"]
        
        let request = AF.request(baseURL.appendingPathComponent("scooters/getScooters"), method: .get, encoding: JSONEncoding.default, headers: .init(headers))
            
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
}
