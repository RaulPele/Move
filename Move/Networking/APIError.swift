//
//  APIError.swift
//  Move
//
//  Created by Raul Pele on 02.09.2022.
//

import Foundation

struct APIError: Error, Decodable {
    let message: String
    var code: Int
}
