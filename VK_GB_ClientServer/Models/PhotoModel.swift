//
//  PhotoModel.swift
//  VK_GB_ClientServer
//
//  Created by Polina Tikhomirova on 26.02.2022.
//

import Foundation

struct Photos {
    let sizes: [Photo]
    let ownerID: Int
}

extension Photos: Codable {
    enum CodingKeys: String, CodingKey {
        case sizes
        case ownerID = "owner_id"
    }
}

struct Photo {
    let url: String
    
    init(url: String) {
        self.url = url
    }
}

extension Photo: Codable {
    enum CodingKeys: String, CodingKey {
        case url
    }
}

struct Attachment: Decodable {
    let type: String
    let photo: Photos?
}
