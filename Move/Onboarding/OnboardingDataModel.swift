//
//  OnboardingDataModel.swift
//  Move
//
//  Created by Raul Pele on 17.08.2022.
//

import Foundation

struct OnboardingData {
    let imageName: String
    let title: String
    let description: String
}

extension OnboardingData {
    static func safety() -> OnboardingData {
        return OnboardingData(imageName: Constants.onboardingSafetyImageName,
                              title: Constants.onboardingSafetyTitle,
                              description: Constants.onboardingSafetyDescription)
    }
    
    static func scan() -> OnboardingData {
        return OnboardingData(imageName: Constants.onboardingScanImageName,
                              title: Constants.onboardingScanTitle,
                              description: Constants.onboardingScanDescription)
    }
    
    static func ride() -> OnboardingData {
        return OnboardingData(imageName: Constants.onboardingRideImageName,
                              title: Constants.onboardingRideTitle,
                              description: Constants.onboardingRideDescription)
    }
    
    static func parking() -> OnboardingData {
        return OnboardingData(imageName: Constants.onboardingParkingImageName,
                              title: Constants.onboardingParkingTitle,
                              description: Constants.onboardingParkingDescription)
    }
    
    static func rules() -> OnboardingData {
        return OnboardingData(imageName: Constants.onboardingRulesImageName,
                              title: Constants.onboardingRulesTitle,
                              description: Constants.onboardingRulesDescription)
    }
}
