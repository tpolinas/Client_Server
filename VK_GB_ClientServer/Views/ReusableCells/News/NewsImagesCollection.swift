//
//  NewsImagesCollection.swift
//  VK_GB_ClientServer
//
//  Created by Polina Tikhomirova on 30.03.2022.
//

import UIKit

class NewsImagesCollection: UITableViewCell,
                            UICollectionViewDelegate,
                            UICollectionViewDataSource {
    
    var currentNews: News? = nil
    var photoURLs: [String] = []
    var numberOfItems = CGFloat()
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var aspect11: NSLayoutConstraint!
    @IBOutlet var aspect21: NSLayoutConstraint!
    @IBOutlet var aspect31: NSLayoutConstraint!
    @IBOutlet var aspect32: NSLayoutConstraint!
    
    override func setSelected(_ selected: Bool,
                              animated: Bool) {
        
        super.setSelected(selected, animated: animated)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        numberOfItems = CGFloat(photoURLs.count)
        configureLayout()
     
        collectionView.register(
               UINib(
                   nibName: "NewsImageCell",
                   bundle: nil),
               forCellWithReuseIdentifier: "newsImageSingle")
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        photoURLs.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "newsImageSingle",
            for: indexPath) as? NewsImageCell
        else { return UICollectionViewCell() }

        cell.configure(url: photoURLs[indexPath.row])
        
        
        return cell
    }
    

    func configureLayout() {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width
        
        aspect11.isActive = false
        aspect21.isActive = false
        aspect31.isActive = false
        aspect32.isActive = false
        

        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        switch numberOfItems {
        case 1:
            aspect11.isActive = true
            layout.itemSize = CGSize(width: width, height: width)
        case 2:
            aspect21.isActive = true
            layout.itemSize = CGSize(width: width / numberOfItems, height: width / numberOfItems)
        case 3:
            aspect31.isActive = true
            layout.itemSize = CGSize(width: width / numberOfItems, height: width / numberOfItems)
        case 4:
            aspect11.isActive = true
            layout.itemSize = CGSize(width: width / 2, height: width / 2)
        case 5, 6:
            aspect32.isActive = true
            layout.itemSize = CGSize(width: width / 3, height: width / 3)
        case 7, 8, 9:
            aspect11.isActive = true
            layout.itemSize = CGSize(width: width / 3, height: width / 3)
        default:
            break
        }
        
        collectionView.collectionViewLayout = layout
        collectionView.reloadData()
    }
}
