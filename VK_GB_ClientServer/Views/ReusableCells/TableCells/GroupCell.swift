//
//  GroupCell.swift
//  VK_GB_ClientServer
//
//  Created by Polina Tikhomirova on 21.12.2021.
//

import UIKit
import Kingfisher

class GroupCell: UITableViewCell {
    @IBOutlet var groupAvatar: UIImageView!
    @IBOutlet var groupName: UILabel!
    @IBAction func avatarPressed() {
        AvatarImage.animateAvatar(groupAvatar)
    }
    
    func configure(name: String, url: String) {
        self.groupAvatar.isHidden = true
        self.groupAvatar.image = nil
        self.groupAvatar.kf.setImage(
            with: URL(string: url),
            placeholder: UIImage(named: "default"),
            options: [.transition(.fade(0.2))])
        self.groupName.text = name
        self.groupAvatar.isHidden = false
    }
}
