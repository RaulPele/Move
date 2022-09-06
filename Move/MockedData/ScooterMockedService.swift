//
//  ScooterMockedService.swift
//  Move
//
//  Created by Raul Pele on 06.09.2022.
//

import Foundation

class ScooterMockedService: ScooterService {
    func getAllScooters() -> [Scooter] {
        return [
            Scooter(id: "#AAAA", status: .unlocked, batteryPercentage: 100, location: .init(latitude: 46.779, longitude: 23.6)),
            Scooter(id: "#BBBB", status: .locked, batteryPercentage: 84, location: .init(latitude: 46.78, longitude: 23.59)),
            Scooter(id: "#CCCC", status: .unlocked, batteryPercentage: 50, location: .init(latitude: 46.771, longitude: 23.585)),
            Scooter(id: "#1234", status: .unlocked, batteryPercentage: 10, location: .init(latitude: 46.75, longitude: 23.580))
        ]
    }
}
