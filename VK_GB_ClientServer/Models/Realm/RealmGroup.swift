//
//  RealmGroup.swift
//  VK_GB_ClientServer
//
//  Created by Polina Tikhomirova on 26.02.2022.
//

import Foundation
import RealmSwift

class GroupRealm: Object {
    @Persisted(primaryKey: true) var id = Int()
    @Persisted var name: String = ""
    @Persisted var avatar: String = ""
}

extension GroupRealm {
    convenience init(group: Group) {
        self.init()
        
        self.id = group.id
        self.name = group.name
        self.avatar = group.avatar
    }
}
