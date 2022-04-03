//
//  Singleton.swift
//  VK_GB_ClientServer
//
//  Created by Polina Tikhomirova on 16.02.2022.
//

import Foundation

final class Singleton {
    
    var token: String = ""
    var userID: Int = 0
    
    static let instance = Singleton()
    
    private init() { }
}
