//
//  AuthenticationService.swift
//  Move
//
//  Created by Raul Pele on 25.08.2022.
//

import Foundation

protocol AuthenticationService {
    func login(email: String, password: String) async
    
}

class AuthenticationAPIService: AuthenticationService {
    var loggedUser: User? = nil
    var url = URL(string: "https://move-scooters.herokuapp.com/users/login")!
    
    func login(email: String, password: String) async {
//        let url = URL(string: "https://move-scooters.herokuapp.com/users/login")
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let uploadData = try? JSONEncoder().encode(User(email: email, password: password))
        request.httpBody = uploadData!
        
        print(String(data: uploadData!, encoding: .utf8))
        do {
            let  response = try await URLSession.shared.data(for: request)
            print(response)
            
//            guard let response = response as? HTTPURLResponse,
//                    (200...299).contains(response.statusCode) else {
//                print ("server error")
//                    return
//                }

            print(response)
//            self.loggedUser = try JSONDecoder().decode(User.self, from: response)
//            print("Username: \(loggedUser?.username), Email: \(loggedUser?.email), Password: \(loggedUser?.password)")
        } catch  {
            print("Login API Call error")
        }
        
    }
}
