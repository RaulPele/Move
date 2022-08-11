//
//  Constants.swift
//  Move
//
//  Created by Raul Pele on 11.08.2022.
//

import Foundation

struct Constants {
    static let onboardingSafetyImageName = "OnboardingSafetyImage"
    static let onboardingSafetyTitle = "Safety"
    static let onboardingSafetyDescription = "Please wear a helmet and protect yourself while riding."
    
    static let onboardingScanImageName = "OnboardingScanImage"
    static let onboardingScanTitle = "Scan"
    static let onboardingScanDescription = "Scan the QR code or NFC sticker on the top of the scooter to unlock and ride."
    
    static let onboardingRideImageName = "OnboardingRideImage"
    static let onboardingRideTitle = "Ride"
    static let onboardingRideDescription = "Step on the scooter with one foot and kick off the ground. When the scooter starts to coast, push the right throttle to accelerate."
    
    static let onboardingParkingImageName = "OnboardingParkingImage"
    static let onboardingParkingTitle = "Parking"
    static let onboardingParkingDescription = "If convenient, park at a bike rack. If not, park close to the edge of the sidewalk closest to the street. Do not block sidewalks, doors or ramps."
    
    static let onboardingRulesImageName = "OnboardingRulesImage"
    static let onboardingRulesTitle = "Rules"
    static let onboardingRulesDescription = "You must be 18 years or and older with a valid driving licence to operate a scooter. Please follow all street signs, signals and markings, and obey local traffic laws."
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
