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
            rankCollectionView.register(RankCollectionViewCell.nib, forCellWithReuseIdentifier: RankCollectionViewCell.identifier)
        }
    }
 
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }

    func setCollectionViewDataSourceDelegate(_ dataSourceDelegate: UICollectionViewDataSource) {
        rankCollectionView.dataSource = dataSourceDelegate
        rankCollectionView.setContentOffset(rankCollectionView.contentOffset, animated:false) // Stops collection view if it was scrolling.
        rankCollectionView.reloadData()
    }
}
