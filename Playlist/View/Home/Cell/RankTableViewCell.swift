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
            rankCollectionView.register(PlaylistsCollectionViewCell.nib, forCellWithReuseIdentifier: PlaylistsCollectionViewCell.identifier)
            if let layout = rankCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
//                let height = layout.itemSize.height
                layout.itemSize = CGSize(width: rankCollectionView.frame.width - 30,
                                         height: PlaylistsCollectionViewCell.frameHeight)
            }
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
