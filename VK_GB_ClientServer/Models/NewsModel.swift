//
//  NewsModel.swift
//  VK_GB_ClientServer
//
//  Created by Polina Tikhomirova on 30.03.2022.
//

import Foundation

struct News {
    let sourceID: Int
    let date: Date
    var text: String?
    let photosURLs: [Attachment]?
    let likes: Likes
    let reposts: Reposts
    let comments: Comments
}

extension News: Decodable {
    enum CodingKeys: String, CodingKey {
        case sourceID = "source_id"
        case date
        case text
        case photosURLs = "attachments"
        case comments
        case likes
        case reposts
    }
}

extension News: Comparable {
    static func < (lhs: News, rhs: News) -> Bool {
        lhs.date < rhs.date
    }
}

extension News: Equatable {
    static func == (lhs: News, rhs: News) -> Bool {
        lhs.date == rhs.date &&
        lhs.sourceID == rhs.sourceID
    }
}


// MARK: - Comments

struct Comments: Codable {
    let count: Int

    enum CodingKeys: String, CodingKey {
        case count
    }
}

struct Likes: Codable {
    let count: Int

    enum CodingKeys: String, CodingKey {
        case count
    }
}

// MARK: - Reposts

struct Reposts: Codable {
    let count: Int

    enum CodingKeys: String, CodingKey {
        case count
    }
}
