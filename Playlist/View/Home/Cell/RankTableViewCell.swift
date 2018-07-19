//
//  RankTableViewCell.swift
//  Playlist
//
//  Created by dev on 2018. 7. 17..
//  Copyright © 2018년 dorenza. All rights reserved.
//

import UIKit

class RankTableViewCell: UITableViewCell {

    @IBOutlet weak var rankCollectionView: UICollectionView! {
        didSet {
            if let flowLayout = rankCollectionView.collectionViewLayout as? LeftAlignedCollectionViewFlowLayout {
                flowLayout.estimatedItemSize = CGSize(width: 1, height: 1)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        rankCollectionView.register(RankCollectionViewCell.nib, forCellWithReuseIdentifier: RankCollectionViewCell.identifier)

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
 
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }

    func setCollectionViewDataSourceDelegate<D: UICollectionViewDataSource & UICollectionViewDelegate>(_ dataSourceDelegate: D) {
        rankCollectionView.delegate = dataSourceDelegate
        rankCollectionView.dataSource = dataSourceDelegate
        rankCollectionView.setContentOffset(rankCollectionView.contentOffset, animated:false) // Stops collection view if it was scrolling.
        rankCollectionView.reloadData()

    }
}
