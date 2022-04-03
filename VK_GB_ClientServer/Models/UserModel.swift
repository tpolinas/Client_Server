//
//  UserModel.swift
//  VK_GB_ClientServer
//
//  Created by Polina Tikhomirova on 26.02.2022.
//

import Foundation

struct User {
    let id: Int
    let firstName: String
    let lastName: String
    let photo: String
    let largePhoto: String
    let sex: Int
    var fullName: String { lastName + " " + firstName }
}

extension User: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case photo = "photo_50"
        case largePhoto = "photo_200"
        case sex
    }
}

extension User: Comparable {
    static func < (lhs: User, rhs: User) -> Bool {
        lhs.lastName < rhs.lastName
    }
}
