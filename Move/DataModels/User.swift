//
//  User.swift
//  Move
//
//  Created by Raul Pele on 25.08.2022.
//

import Foundation

struct User {
    let email: String
    let username: String? = nil
    let password: String
    
    enum CodingKeys: String, CodingKey {
        case email = "mail"
        case username = "name"
        case password
    }
    
   
}

extension User: Codable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(email, forKey: .email)
        try container.encode(password, forKey: .password)
    }
}
