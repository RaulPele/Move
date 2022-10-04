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
    
    func getUser(completionHandler: @escaping (Result<User, Error>) -> Void) {
        guard let sessionToken = sessionManager.getSessionToken() else { return }
        
        let headers = ["Authorization": "Bearer \(sessionToken)"]
        
        let request = AF.request(baseURL.appendingPathComponent("users/me"),
                                 method: .get,
                                 headers: .init(headers))
        request
            .validate(statusCode: 200..<300)
            .responseDecodable(of: UserResponse.self) { response in
                switch response.result {
                case .success(let userResponse) :
                    let user = userResponse.userDTO.toUser()
                    completionHandler(.success(user))
                    
                case .failure(let error) :
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
