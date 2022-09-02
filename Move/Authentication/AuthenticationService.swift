//
//  AuthenticationService.swift
//  Move
//
//  Created by Raul Pele on 25.08.2022.
//

import Foundation
import Alamofire

protocol AuthenticationService {
    func login(email: String, password: String, onLoginCompleted: @escaping () -> Void)
    func register(email: String, password: String, username: String, onRegisterCompleted: @escaping () -> Void)
}
//TODO: networking layer
class AuthenticationAPIService: AuthenticationService {
    var url = URL(string: "https://move-scooters.herokuapp.com/users/login")!
    
    func login(email: String, password: String, onLoginCompleted: @escaping () -> Void) {
        guard Validation.isValid(email: email) && Validation.isValid(password: password) else {
            return
        }
        
        let parameters = ["mail": email, "password": password]
        let headers = ["Content-Type": "application/json"]
        
        let request = AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: .init(headers))
        request
            .validate(statusCode: 200..<300)
            .responseDecodable(of: LoginData.self) { response in
                switch response.result {
                    case .success(let loginData):
                        print("success")
                    
                        self.saveUserData(userData: loginData)
                        onLoginCompleted()
                    case .failure(let error):
                        print("Error: \(error.localizedDescription)")
                        if let data = response.data,
                           let apiError = try? JSONDecoder().decode(APIError.self, from: data) {
                            //completion(.failure(apiError))
                        } else {
                           // completion(.failure(error))
                        }

                }
        //TODO: handle errors
            }
    }
    
    func register(email: String, password: String, username: String, onRegisterCompleted: @escaping () -> Void) {
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
        
        let request = AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
        request
            .validate(statusCode: 200..<300)
            .responseDecodable(of: LoginData.self) { response in
                switch response.result {
                case .success(let loginData):
                    print("succesfully registered")
                    self.saveUserData(userData: loginData)
                    onRegisterCompleted()
                    
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                    if let data = response.data {
                        print("Data: \(String(data: data, encoding: .utf8))")
                    }
                }
            }
    }
    
    private func saveUserData(userData: LoginData) {
        let encoder = JSONEncoder()
        let userData = try? encoder.encode(userData)
        if let userData = userData {
            UserDefaults.standard.set(userData, forKey: "userData")
        }
    }
}
