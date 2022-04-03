//
//  NewsImageCellCollectionViewCell.swift
//  VK_GB_ClientServer
//
//  Created by Polina Tikhomirova on 30.03.2022.
//

import UIKit
import Kingfisher

class NewsImageCell: UICollectionViewCell,
                     UIGestureRecognizerDelegate {

    @IBOutlet var newsImage: UIImageView!
    
    func configure(url: String) {
        self.newsImage.isHidden = true
        self.newsImage.image = nil
        self.newsImage.kf.setImage(
            with: URL(string: url),
            placeholder: UIImage(named: "default"),
            options: [.transition(.fade(0.2))])
        self.newsImage.contentMode = .scaleAspectFit
        self.newsImage.isHidden = false
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        newsImage.image = nil
    }
}
