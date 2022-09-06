//
//  SessionService.swift
//  Move
//
//  Created by Raul Pele on 06.09.2022.
//

import Foundation

enum UserDefaultsKeys: String {
    case userData = "userData"
}

enum CodingError: Error {
    case userEncodingError(String)
    case userDecodingError(String)
}

class SessionManager {
    func saveUserData(userDTO: UserDTO) throws {
        let encoder = JSONEncoder()
        
        do {
            let userData = try encoder.encode(userDTO)
            UserDefaults.standard.set(userData, forKey: UserDefaultsKeys.userData.rawValue)
        } catch {
            throw CodingError.userEncodingError("Cannot encode user!")
        }
    }
    
    func getUserData() -> UserDTO? {
        let userData = UserDefaults.standard.data(forKey: UserDefaultsKeys.userData.rawValue)
       
        guard let userData = userData else {
            return nil
        }

        let decoder = JSONDecoder()
        let userDTO = try? decoder.decode(UserDTO.self, from: userData)
        return userDTO
    }
    
    func getSessionToken() -> String? {
        return getUserData()?.sessionToken
    }
    
    func deleteUserData() {
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.userData.rawValue)
    }
}
