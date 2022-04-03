//
//  NewsTopCell.swift
//  VK_GB_ClientServer
//
//  Created by Polina Tikhomirova on 30.03.2022.
//

import UIKit
import Kingfisher

class NewsTopCell: UITableViewCell {

    @IBOutlet var groupAvatar: UIImageView!
    @IBOutlet var groupName: UILabel!
    @IBOutlet var newsTime: UILabel!
    
    func configure(avatar: String,
                   name: String,
                   newsTime: String) {
        self.groupAvatar.image = nil
        self.groupAvatar.kf.setImage(with: URL(string: avatar))
        self.groupName.text = name
        self.newsTime.text = newsTime
    }
}
