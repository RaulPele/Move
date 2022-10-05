//
//  UserMockedService.swift
//  Move
//
//  Created by Raul Pele on 05.10.2022.
//

import Foundation

class UserMockedService: UserService {
    func getUser(completionHandler: @escaping (Result<UserDetails, Error>) -> Void) {
        
    }
    
    func getUserTrips(completionHandler: @escaping (Result<[FormattedTripData], Error>) -> Void) {
        var trips = [FormattedTripData]()
        
        for i in 0..<30 {
            let trip: FormattedTripData
            
            if i.isMultiple(of: 2){
                 trip = FormattedTripData(id: "\(i)", startAddress: "Str. Lunii 2A", endAddress: "Str. Meteor", travelTime: 1000, distance: 2800)
            } else {
                trip = FormattedTripData(id: "\(i)", startAddress: "Str. Corneliu Coposu 1", endAddress: "Str. Horea 23", travelTime: 600, distance: 1500)
            }
            trips.append(trip)
        }
        
        completionHandler(.success(trips))
    }
    
    
}
