//
//  Items.swift
//  VK_GB_ClientServer
//
//  Created by Polina Tikhomirova on 31.03.2022.
//

import Foundation

struct Items<ItemsType: Decodable>: Decodable {
    let items: [ItemsType]
    let count: Int?
}
