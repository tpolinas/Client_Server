//
//  Response.swift
//  VK_GB_ClientServer
//
//  Created by Polina Tikhomirova on 31.03.2022.
//

import Foundation

struct Response<ItemsType: Decodable>: Decodable {
    let response: Items<ItemsType>
}
