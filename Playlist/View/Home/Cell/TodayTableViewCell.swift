//
//  TodayTableViewCell.swift
//  Playlist
//
//  Created by dev on 2018. 7. 17..
//  Copyright © 2018년 dorenza. All rights reserved.
//

import UIKit

class TodayTableViewCell: UITableViewCell {

    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var viewCountLabel: UILabel!
    @IBOutlet weak var bookmarkCountLabel: UILabel!
    @IBOutlet weak var tagCollectionView: UICollectionView! {
        didSet {
            tagCollectionView.register(TagCollectionViewCell.nib, forCellWithReuseIdentifier: TagCollectionViewCell.identifier)
            if let flowLayout = tagCollectionView.collectionViewLayout as? CenterViewFlowLayout {
                flowLayout.estimatedItemSize = CGSize(width: 1, height: 1)
                flowLayout.scrollDirection = .horizontal
                flowLayout.minimumLineSpacing = 0
            }
        }
    }
    
    var delegate: HomeViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(touchCell))
        addGestureRecognizer(tapGestureRecognizer)
        
    }
  
    @objc func touchCell(sender: UITapGestureRecognizer) {
        delegate?.touchCell(sender: sender)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUp(title: String, desc: String, imgUrl: URL, screenSize: CGRect, viewCount: Int, bookmarkCount: Int) {
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
    
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
}

protocol HomeViewCellDelegate {
    func touchCell(sender: UITapGestureRecognizer)
}
