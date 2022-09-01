//
//  User.swift
//  Move
//
//  Created by Raul Pele on 25.08.2022.
//

import Foundation

struct User {
    let email: String
    var username: String? = nil
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
    
//    init(from decoder: Decoder) throws {
//        var body = try decoder.unkeyedContainer()
//        var values = try body.nestedContainer(keyedBy: CodingKeys.self)
//        print("In decoder: ")
//        print(valu)
//        email = try values.decode(String.self, forKey: .email)
//        password = try values.decode(String.self, forKey: .password)
//        username = try values.decode(String.self, forKey: .username)
//    }
}
//TODO: rename
struct LoginData: Codable {
    var user: User
    var token: String
}
