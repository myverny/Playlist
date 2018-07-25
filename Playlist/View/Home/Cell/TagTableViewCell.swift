//
//  TagTableViewCell.swift
//  Playlist
//
//  Created by dev on 2018. 7. 24..
//  Copyright © 2018년 dorenza. All rights reserved.
//

import UIKit

class TagTableViewCell: UITableViewCell {
    @IBOutlet weak var tagNameLabel: UILabel!
    @IBOutlet weak var playlistCollectionView: UICollectionView! {
        didSet {
            playlistCollectionView.register(TagTableCollectionViewCell.nib, forCellWithReuseIdentifier: TagTableCollectionViewCell.identifier)
            if let layout = playlistCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                //                let height = layout.itemSize.height
                layout.itemSize = CGSize(width: playlistCollectionView.frame.width - 30,
                                         height: TagTableCollectionViewCell.frameHeight)
            }
        }
    }
    
    func setUp(title: String) {
        self.tagNameLabel.text = title
    }
 
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    func setCollectionViewDataSourceDelegate<D: UICollectionViewDataSource & UICollectionViewDelegate>(_ dataSourceDelegate: D, forRow: Int) {
        playlistCollectionView.dataSource = dataSourceDelegate
        playlistCollectionView.delegate = dataSourceDelegate
        playlistCollectionView.setContentOffset(playlistCollectionView.contentOffset, animated:false) // Stops collection view if it was scrolling.
        playlistCollectionView.tag = forRow
        playlistCollectionView.reloadData()
    }
}
