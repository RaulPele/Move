//
//  RideAPIService.swift
//  Move
//
//  Created by Raul Pele on 03.10.2022.
//

import Foundation
import Alamofire
import MapKit

class RideAPIService: RideService {
    let baseURL = URL(string: "https://move-scooters.herokuapp.com/api")!
    let sessionManager: SessionManager
    
    init(sessionManager: SessionManager) {
        self.sessionManager = sessionManager
    }
    
    func startRide(scooterId: String, userLocation: CLLocation, completionHandler: @escaping (Result<TripData, Error>) -> Void) {
        guard let sessionToken = sessionManager.getSessionToken() else { return }
        
        let headers = ["Authorization" : "Bearer \(sessionToken)"]
        let parameters: [String : Any] = [
            "latitude" : userLocation.coordinate.latitude,
            "longitude": userLocation.coordinate.longitude
        ]
        
        let url = baseURL.appendingPathComponent("trips/\(scooterId)")
        
        let request = AF.request(url,
                                 method: .post,
                                 parameters: parameters,
                                 encoding: JSONEncoding.default,
                                 headers: .init(headers))
        
        request
            .validate(statusCode: 200..<300)
            .responseDecodable(of: TripResponse.self) { response in
                switch response.result {
                case .success(let tripResponse):
                    let tripData: TripData = .init(trip: tripResponse.tripDTO.toTrip(), scooter: tripResponse.scooterDTO.toScooter())
                    completionHandler(.success(tripData))
                    
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
    
    func endRide(scooterId: String, userLocation: CLLocation, completionHandler: @escaping (Result<TripData, Error>) -> Void) {
        guard let sessionToken = sessionManager.getSessionToken() else { return }
        
        let headers = ["Authorization" : "Bearer \(sessionToken)"]
        
        let bodyParameters: [String : Any] = [
            "latitude" : userLocation.coordinate.latitude,
            "longitude": userLocation.coordinate.longitude
        ]
        
        let queryParameters = [
            "id": scooterId
        ]
        
        let url = baseURL.appendingPathComponent("trips/end/\(scooterId)")
        let request = AF.request(url,
                                 method: .patch,
                                 parameters: bodyParameters,
                                 encoding: JSONEncoding.default,
                                 headers: .init(headers))
        
        request
            .validate(statusCode: 200..<300)
        print(request.error)

            request.responseDecodable(of: EndTripResponse.self) { response in
                switch response.result {
                case .success(let tripResponse):
                    let tripData: TripData = .init(trip: tripResponse.tripDTO.toTrip(), scooter: tripResponse.scooterDTO.toScooter())
                    completionHandler(.success(tripData))
                    
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
    
    func getRideInformation(scooterId: String, completionHandler: @escaping (Result<TripData, Error>) -> Void) {
        guard let sessionToken = sessionManager.getSessionToken() else { return }
        
        let headers = ["Authorization": "Bearer \(sessionToken)"]
        let url = baseURL.appendingPathComponent("trips/current/\(scooterId)")
        
        let request = AF.request(url,
                                 method:.get,
                                 headers: .init(headers))
        
        request
            .validate(statusCode: 200..<300)
            .responseDecodable(of: GetTripResponse.self) { response in
                switch response.result {
                case .success(let tripResponse):
                    let tripData: TripData = .init(trip: tripResponse.tripDTO.toTrip(), scooter: tripResponse.scooterDTO.toScooter())
                    completionHandler(.success(tripData))
                    
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
    
    func lockRide(scooterId: String,
                  userLocation: CLLocation,
                  completionHandler: @escaping (Result<TripData, Error>) -> Void) {
        guard let sessionToken = sessionManager.getSessionToken() else { return }
        
        let headers = ["Authorization": "Bearer \(sessionToken)"]
        
        let parameters: [String : Any] = [
            "latitude" : userLocation.coordinate.latitude,
            "longitude": userLocation.coordinate.longitude
        ]
        
        let url = baseURL.appendingPathComponent("trips/lock/\(scooterId)")
        let request = AF.request(url,
                                 method: .patch,
                                 parameters: parameters,
                                 encoding: JSONEncoding.default,
                                 headers: .init(headers)
        )
        
        request.validate(statusCode: 200..<300)
            .responseDecodable(of: LockRideResponse.self) { response in
                switch response.result {
                case .success(let lockRideResponse):
                    let tripData: TripData = .init(trip: lockRideResponse.tripDTO.toTrip(), scooter: lockRideResponse.scooterDTO.toScooter())
                    
                    completionHandler(.success(tripData))
                    
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
    
    func unlockRide(scooterId: String, userLocation: CLLocation,
                    completionHandler: @escaping (Result<TripData, Error>) -> Void) {
        
        guard let sessionToken = sessionManager.getSessionToken() else { return }
        let headers = ["Authorization": "Bearer \(sessionToken)"]
        let parameters: [String : Any] = [
            "latitude" : userLocation.coordinate.latitude,
            "longitude": userLocation.coordinate.longitude
        ]
        
        let url = baseURL.appendingPathComponent("trips/unlock/\(scooterId)")
        let request = AF.request(url,
                                 method: .patch,
                                 parameters: parameters,
                                 encoding: JSONEncoding.default,
                                 headers: .init(headers)
        )
        
        request.validate(statusCode: 200..<300)
            .responseDecodable(of: LockRideResponse.self) { response in
                switch response.result {
                case .success(let lockRideResponse):
                    let tripData: TripData = .init(trip: lockRideResponse.tripDTO.toTrip(), scooter: lockRideResponse.scooterDTO.toScooter())
                    
                    completionHandler(.success(tripData))
                    
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
