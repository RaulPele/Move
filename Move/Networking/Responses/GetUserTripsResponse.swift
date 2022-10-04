//
//  GetUserTripsResponse.swift
//  Move
//
//  Created by Raul Pele on 05.10.2022.
//

import Foundation

struct GetUserTripsResponse: Codable {
    let trips: [TripDTO]
    
    enum CodingKeys: String, CodingKey {
        case trips = "trips"
    }
}
