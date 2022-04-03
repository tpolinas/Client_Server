//
//  RealmFeed.swift
//  VK_GB_ClientServer
//
//  Created by Polina Tikhomirova on 31.03.2022.
//

import Foundation
import RealmSwift

final class RealmNews: Object {
    @Persisted(primaryKey: true) var id = ""
    @Persisted var sourceID: Int?
    @Persisted var date = Date()
    @Persisted var text = ""
    @Persisted var commentCount = 0
    @Persisted var likeCount = 0
    @Persisted var repostsCount = 0
}

extension RealmNews {
    convenience init(
            sourceID: Int,
            date: Date,
            text: String,
            commentsCount: Int,
            repostsCount: Int)  {
                
        self.init()
                
        self.id = String(sourceID) + "_" + date.toString(dateFormat: .dateTime)
        self.sourceID = sourceID
        self.date = date
        self.text = text
        self.commentCount = commentsCount
        self.likeCount = 0
        self.repostsCount = repostsCount
    }
}

