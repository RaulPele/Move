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
            .validate()
            .responseDecodable(of: LoginResponse.self) { response in
                switch response.result {
                    case .success(let loginResponse):
                        print("success")
                        self.loggedUser = loginResponse.user
                        self.token = loginResponse.token
                        onLoginCompleted()
                    case .failure(let error):
                        print("Error: \(error.localizedDescription)")
                
                }
        }
        
        //try to decode it as json. if password is wrong the structure of the json will be different
    }
}
