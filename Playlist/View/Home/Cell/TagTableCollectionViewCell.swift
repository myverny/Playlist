//
//  TagCollectionViewCell.swift
//  Playlist
//
//  Created by dev on 2018. 7. 24..
//  Copyright © 2018년 dorenza. All rights reserved.
//

import UIKit

class TagTableCollectionViewCell: UICollectionViewCell {
    static var frameHeight = CGFloat(320)

    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var viewCountLabel: UILabel!
    @IBOutlet weak var bookmarkCountLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
  
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    func setUp(title: String, desc: String, imgUrl: URL, viewCount: Int, bookmarkCount: Int) {
        titleLabel?.text = title
        descLabel?.text = desc
        viewCountLabel?.text = viewCount.toAbbr() + " views"
        bookmarkCountLabel?.text = bookmarkCount.toAbbr() + " bookmarks"
        
        DispatchQueue.global().async() {
            let imageData = try? Data(contentsOf: imgUrl)
            DispatchQueue.main.async() { [weak self] in
                if imageData != nil, let image = UIImage(data: imageData!) {
                    self?.thumbnailImageView?.image = image
                }
            }
        }
    }
}
