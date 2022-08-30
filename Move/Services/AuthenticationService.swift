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

class AuthenticationAPIService: AuthenticationService {
    var loggedUser: User? = nil
    var token: String? = nil
    var url: URL
    
    init(url: String) {
        self.url = URL(string: url)!
    }
    
    func login(email: String, password: String, onLoginCompleted: @escaping () -> Void) {
        guard Validation.validate(email: email) && Validation.validate(password: password) else {
            return
        }
        
        let parameters = ["mail": email, "password": password]
        
        let request = AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
        request
            .validate(statusCode: 200..<300)
            .responseDecodable(of: LoginResponse.self) { response in
                switch response.result {
                    case .success(let loginResponse):
                        print("success")
                        self.loggedUser = loginResponse.user
                        self.token = loginResponse.token
                        onLoginCompleted()
                    case .failure(let error):
                        print("Error: \(error.localizedDescription)")
                    if let data = response.data {
                        print("Data: \(String(data: data, encoding: .utf8))")
                    }

                }
        //try to decode it as json. if password is wrong the structure of the json will be different
            }
    }
    
    func register(email: String, password: String, username: String, onRegisterCompleted: @escaping () -> Void) {
        guard Validation.validate(email: email) &&
                Validation.validate(password: password) &&
                Validation.validate(username: username) else {
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
            .responseDecodable(of: LoginResponse.self) { response in
                switch response.result {
                case .success(let loginResponse):
                    print("succsesfully registered")
                    self.loggedUser = loginResponse.user
                    onRegisterCompleted()
                    
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                    if let data = response.data {
                        print("Data: \(String(data: data, encoding: .utf8))")
                    }
                }
            }
    }
}
