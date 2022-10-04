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
            .responseDecodable(of: LoginResponse.self) { response in
                switch response.result {
                    case .success(let loginResponse):
                    try? self.sessionManager.saveSession(token: loginResponse.userDTO.sessionToken ?? "")
                    completionHandler(.success(loginResponse.userDTO.toUser()))
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
        
        let request = AF.request(baseURL.appendingPathComponent("api/auth/register"),
                                 method: .post, parameters: parameters, encoding: JSONEncoding.default)
        request
            .validate(statusCode: 200..<300)
            .responseDecodable(of: RegisterResponse.self) { response in
                switch response.result {
                case .success(let registerResponse):
                    print("succesfully registered")
                    try? self.sessionManager.saveSession(token: registerResponse.userDTO.sessionToken ?? "")
                    completionHandler(.success(registerResponse.userDTO.toUser()))
                    
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
    
    func logout(completionHandler: @escaping (Result<String, Error>) -> Void) {
        guard let sessionToken = sessionManager.getSessionToken() else { return }
        
        let headers = ["Authorization" : "Bearer \(sessionToken)"]
        
        let request = AF.request(baseURL.appendingPathComponent("api/auth/logout"),
                          method: .delete,
                          headers: .init(headers))
        
        request.validate(statusCode: 200..<300)
            .responseDecodable(of: String.self) { [weak self] response in
                guard let self = self else { return }
                
                switch response.result {
                case .success(let message):
                    self.sessionManager.invalidateSession()
                    completionHandler(.success(message))
                    
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
