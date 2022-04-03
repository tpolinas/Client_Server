//
//  FriendCell.swift
//  VK_GB_ClientServer
//
//  Created by Polina Tikhomirova on 21.12.2021.
//

import UIKit
import Kingfisher

class FriendCell: UITableViewCell {
    @IBOutlet var friendAvatar: UIImageView!
    @IBOutlet var friendName: UILabel!
    @IBAction func avatarPressed() {
        AvatarImage.animateAvatar(friendAvatar)
    }
    
    func configure(name: String, url: String) {
        self.friendAvatar.isHidden = true
        self.friendAvatar.image = nil
        self.friendAvatar.kf.setImage(
            with: URL(string: url),
            placeholder: UIImage(named: "default"),
            options: [.transition(.fade(0.2))])
        self.friendName.text = name
        self.friendAvatar.isHidden = false
    }
}
