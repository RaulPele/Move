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
    
    func login(email: String, password: String, completionHandler: @escaping (Result<User, Error>) -> Void) {
        guard Validation.isValid(email: email) && Validation.isValid(password: password) else {
            return
        }
        
        let parameters = ["mail": email, "password": password]
        let headers = ["Content-Type": "application/json"]
        
        let request = AF.request(baseURL.appendingPathComponent("users/login"), method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: .init(headers))
        request
            .validate(statusCode: 200..<300)
            .responseDecodable(of: AuthenticationResponse.self) { response in
                switch response.result {
                    case .success(let authenticationData):
                        self.saveUserData(userData: authenticationData)
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
        
        let request = AF.request(baseURL.appendingPathComponent("users/register"), method: .post, parameters: parameters, encoding: JSONEncoding.default)
        request
            .validate(statusCode: 200..<300)
            .responseDecodable(of: AuthenticationResponse.self) { response in
                switch response.result {
                case .success(let authenticationData):
                    print("succesfully registered")
                    self.saveUserData(userData: authenticationData)
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
    
    private func saveUserData(userData: AuthenticationResponse) {
        let encoder = JSONEncoder()
        let userData = try? encoder.encode(userData)
        if let userData = userData {
            UserDefaults.standard.set(userData, forKey: "userData")
        }
    }
}
