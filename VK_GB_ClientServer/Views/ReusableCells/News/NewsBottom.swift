//
//  NewsBottom.swift
//  VK_GB_ClientServer
//
//  Created by Polina Tikhomirova on 30.03.2022.
//

import UIKit

class NewsBottom: UITableViewCell {

    @IBOutlet var likeButton: UIButton!
    @IBOutlet var commentsButton: UIButton!
    @IBOutlet var shareButton: UIButton!
   
    
    @IBAction func buttonPressed(_ sender: UIButton) { }
    
    
    func configure(isLiked: Bool,
                   likesCounter: Int,
                   commentsCounter: Int,
                   sharedCounter: Int) {
        if isLiked {
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            likeButton.setTitle("\(likesCounter)", for: .normal)
            likeButton.tintColor = .systemBlue
        } else {
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
            likeButton.setTitle("\(likesCounter)", for: .normal)
            likeButton.tintColor = .systemRed
        }
        
        commentsButton.setTitle("\(commentsCounter)", for: .normal)
        shareButton.setTitle("\(sharedCounter)", for: .normal)

    }
}
