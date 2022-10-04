//
//  UserService.swift
//  Move
//
//  Created by Raul Pele on 04.10.2022.
//

import Foundation

protocol UserService {
    func getUser(completionHandler: @escaping (Result<UserDetails, Error>) -> Void )
    func getUserTrips(completionHandler: @escaping (Result<[Trip], Error>) -> Void)
//    func getUserDetails(completionHandler: @escaping (Result<Int, Error>) -> Void)
}
