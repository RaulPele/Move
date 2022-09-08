//
//  UserDTO.swift
//  Move
//
//  Created by Raul Pele on 05.09.2022.
//

import Foundation

struct UserDTO : Codable {
    var username: String
    var email: String
    var password: String
    var status: String?
    var sessionToken: String?
    var createdAt: String?
    var updatedAt: String?
    var licenseImageLink: String?
    
    enum CodingKeys: String, CodingKey {
        case username = "name"
        case email = "mail"
        case password
        case status
        case sessionToken = "session_token"
        case createdAt
        case updatedAt
        case licenseImageLink = "productImage"
    }
}

extension UserDTO {
    func toUser() -> User {
        return User(email: email, username: username, password: password)
    }
}
