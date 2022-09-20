//
//  File.swift
//  Move
//
//  Created by Raul Pele on 06.09.2022.
//

import Foundation

protocol ScooterService {
    func getAllScooters(completionHandler: @escaping (Result<[Scooter], Error>) -> Void)
    func unlock(scooter: Scooter, completionHandler: @escaping (Result<Scooter, Error>) -> Void)
}
