//
//  AuthenticationService.swift
//  Move
//
//  Created by Raul Pele on 25.08.2022.
//

import Foundation
import Alamofire


protocol AuthenticationService {
    func login(email: String, password: String, onLogin: @escaping () -> Void)
    
}

class AuthenticationAPIService: AuthenticationService {
    var loggedUser: User? = nil
    var token: String? = nil
    var url = URL(string: "https://move-scooters.herokuapp.com/users/login")!
    
    func login(email: String, password: String, onLogin: @escaping () -> Void) {
        let request = AF.request(url, method: .post, parameters: ["mail": email, "password": password], encoding: JSONEncoding.default)
        request
            .validate()
            .responseDecodable(of: LoginResponse.self) { response in
                switch response.result {
                    case .success(let loginResponse):
                        print("success")
                        self.loggedUser = loginResponse.user
                        self.token = loginResponse.token
                        onLogin()
                    case .failure(let error):
                        print("Error: \(error.localizedDescription)")
                }
        }
    }
}
