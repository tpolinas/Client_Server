//
//  ProfileHeader.swift
//  VK_GB_ClientServer
//
//  Created by Polina Tikhomirova on 22.12.2021.
//

import UIKit
import Kingfisher

class ProfileHeader: UICollectionReusableView {

    @IBOutlet var friendName: UILabel!
    @IBOutlet var friendAvatar: UIImageView!
    @IBOutlet var friendGender: UILabel!
    @IBAction func avatarPressed() {
        AvatarImage.animateAvatar(friendAvatar)
    }

    func configure(
        friendName: String,
        url: String,
        friendGender: String) {
            self.friendName.text = friendName
            self.friendAvatar.kf.setImage(with: URL(string: url))
            self.friendGender.text = "Gender: \(friendGender)"
    }
}
