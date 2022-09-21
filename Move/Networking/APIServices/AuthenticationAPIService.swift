//
//  AuthenticationService.swift
//  Move
//
//  Created by Raul Pele on 25.08.2022.
//

import Foundation
import Alamofire

class AuthenticationAPIService: AuthenticationService {
    var baseURL = URL(string: "https://move-scooters.herokuapp.com")!
    let sessionManager: SessionManager
    
    init(sessionManager: SessionManager) {
        self.sessionManager = sessionManager
    }
    
    func login(email: String, password: String, completionHandler: @escaping (Result<User, Error>) -> Void) {
        guard Validation.isValid(email: email) && Validation.isValid(password: password) else {
            return
        }
        
        let parameters = ["mail": email, "password": password]
        let headers = ["Content-Type": "application/json"]
        
        let request = AF.request(baseURL.appendingPathComponent("api/auth/login"), method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: .init(headers))
        request
            .validate(statusCode: 200..<300)
            .responseDecodable(of: AuthenticationResponse.self) { response in
                switch response.result {
                    case .success(let authenticationData):
                    try? self.sessionManager.saveUserData(userDTO: authenticationData.userDTO)
                    completionHandler(.success(authenticationData.userDTO.toUser()))
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
    
    func register(email: String, password: String, username: String, completionHandler: @escaping (Result<User, Error>) -> Void) {
        guard Validation.isValid(email: email) &&
                Validation.isValid(password: password) &&
                Validation.isValid(username: username) else {
            print("Validation error")
            return
        }
        
        let parameters = [
            "name": username,
            "mail": email,
            "password": password
        ]
        
        let request = AF.request(baseURL.appendingPathComponent("api/auth/register"), method: .post, parameters: parameters, encoding: JSONEncoding.default)
        request
            .validate(statusCode: 200..<300)
            .responseDecodable(of: AuthenticationResponse.self) { response in
                switch response.result {
                case .success(let authenticationData):
                    print("succesfully registered")
                    try? self.sessionManager.saveUserData(userDTO: authenticationData.userDTO)
                    completionHandler(.success(authenticationData.userDTO.toUser()))
                    
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
