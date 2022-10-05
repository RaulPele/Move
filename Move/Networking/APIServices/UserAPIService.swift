//
//  UserAPIService.swift
//  Move
//
//  Created by Raul Pele on 04.10.2022.
//

import Foundation
import Alamofire

class UserAPIService: UserService {
    let baseURL = URL(string: "https://move-scooters.herokuapp.com/api")!
    let sessionManager: SessionManager
    
    init(sessionManager: SessionManager) {
        self.sessionManager = sessionManager
    }
    
    func getUser(completionHandler: @escaping (Result<UserDetails, Error>) -> Void) {
        guard let sessionToken = sessionManager.getSessionToken() else { return }
        
        let headers = ["Authorization": "Bearer \(sessionToken)"]
        
        let request = AF.request(baseURL.appendingPathComponent("users/me"),
                                 method: .get,
                                 headers: .init(headers))
        request
            .validate(statusCode: 200..<300)
            .responseDecodable(of: GetUserResponse.self) { response in
                switch response.result {
                case .success(let userResponse) :
                    let userDetails: UserDetails = .init(user: userResponse.userDTO.toUser(),
                                                         numberOfTrips: userResponse.numberOfTrips)
                    completionHandler(.success(userDetails))
                    
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
    func getUserTrips(completionHandler: @escaping (Result<[FormattedTripData], Error>) -> Void) {
        
    }
//    func getUserTrips(completionHandler: @escaping (Result<[Trip], Error>) -> Void) {
//        guard let sessionToken = sessionManager.getSessionToken() else { return }
//
//        let headers = ["Authorization" : "Bearer \(sessionToken)"]
//
//        let request = AF.request(baseURL.appendingPathComponent("trips/me"),
//                                 method: .get,
//                                 headers: .init(headers))
//
//        request
//            .validate(statusCode: 200..<300)
//            .responseDecodable(of: GetUserTripsResponse.self) { response in
//                switch response.result {
//                case .success(let userTripsResponse):
//                    let tripDTOs = userTripsResponse.trips
//                    var trips = [Trip]()
//
//                    for dto in tripDTOs {
//                        trips.append(dto.toTrip())
//                    }
//
//                    completionHandler(.success(trips))
//
//                case .failure(let error):
//                    if let data = response.data,
//                       let apiError = try? JSONDecoder().decode(APIError.self, from: data) {
//                        completionHandler(.failure(apiError))
//                    } else {
//                        completionHandler(.failure(error))
//                    }
//                }
//            }
//    }
}
