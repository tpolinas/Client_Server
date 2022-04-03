//
//  RealmPhotos.swift
//  VK_GB_ClientServer
//
//  Created by Polina Tikhomirova on 26.02.2022.
//

import Foundation
import RealmSwift

class PhotoRealm: Object {
    @Persisted(indexed: true) var ownerID: Int = Int()
    @Persisted(primaryKey: true) var url: String = ""
}

extension PhotoRealm {
    convenience init(ownerID: Int, photo: Photos) {
        self.init()
        
        self.ownerID = ownerID
        self.url = photo.sizes.last!.url
    }
}
