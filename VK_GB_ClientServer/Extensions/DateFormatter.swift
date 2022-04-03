//
//  DateFormatter.swift
//  VK_GB_ClientServer
//
//  Created by Polina Tikhomirova on 31.03.2022.
//

import Foundation

extension Date {
    enum DateFormat: String {
        case dateTime = "dd.MM.yy, HH:mm"
        case date = "dd.MM.yy"
    }
    
    func toString(dateFormat: DateFormat) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat.rawValue
        return dateFormatter.string(from: self)
    }
}

