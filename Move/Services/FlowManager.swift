//
//  FlowManager.swift
//  Move
//
//  Created by Raul Pele on 04.10.2022.
//

import Foundation


class FlowManager {
    let sessionManager: SessionManager
    let userService: UserService
    
    init(sessionManager: SessionManager, userService: UserService) {
        self.sessionManager = sessionManager
        self.userService = userService
    }
    
    func markAsOnboarded() {
        UserDefaults.standard.set(true, forKey: UserDefaultsKeys.onboardingState.rawValue)
    }
    
    func markAsDrivingLicenseVerified() {
        UserDefaults.standard.set(true, forKey: UserDefaultsKeys.drivingLicenseVerification.rawValue)
    }
    
    func userIsOnboard() -> Bool {
        let onboardingFlag = UserDefaults.standard.bool(forKey: UserDefaultsKeys.onboardingState.rawValue)
        
        if onboardingFlag {
            print("Onboarding status: \(onboardingFlag)")
            return true
        }
        return false
    }
    
    func userIsLoggedIn() -> Bool {
        if sessionManager.getSessionToken() != nil {
            return true
       } else {
           return false
       }
    }
    
    
    func getApplicationFlow(completionHandler: @escaping (MainCoordinatorState) -> Void){
        if !userIsOnboard() {
            completionHandler(.onboarding)
            return
        }
        
        if !userIsLoggedIn() {
            completionHandler(.authentication)
            return
        }
        
        userService.getUser { result in
            switch result {
            case .success(let user):
                if let licenseImageLink = user.licenseImageLink {
                    if licenseImageLink.isEmpty {
                        completionHandler(.drivingLicenseVerification)
                    }else {
                        completionHandler(.map)
                    }
                } else {
                    completionHandler(.drivingLicenseVerification)
                }
            case .failure(let failure):
                completionHandler(.authentication)
            }
        }
        
    }
}
