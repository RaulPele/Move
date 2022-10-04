//
//  SessionService.swift
//  Move
//
//  Created by Raul Pele on 06.09.2022.
//

import Foundation

class SessionManager {
    func saveSession(token: String) throws {
        if !token.isEmpty {
            UserDefaults.standard.set(token, forKey: UserDefaultsKeys.sessionToken.rawValue)
        }
    }
    
    func getSessionToken() -> String? {
        return UserDefaults.standard.string(forKey: UserDefaultsKeys.sessionToken.rawValue)
    }
    
    func invalidateSession() {
        if getSessionToken() != nil {
            UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.sessionToken.rawValue)
        }
    }
}
