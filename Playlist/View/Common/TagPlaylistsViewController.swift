//
//  TagPlaylistsViewController.swift
//  Playlist
//
//  Created by DONGHYUN KIM on 2018. 7. 18..
//  Copyright © 2018년 dorenza. All rights reserved.
//

import UIKit

class TagPlaylistsViewController: UIViewController {
    var tag: Tag! {
        didSet {
            self.title = "#\(tag.name)"
        }
    }
    private var viewModel: TagPlaylistsViewModel!
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.setContentOffset(collectionView.contentOffset, animated:false)
            collectionView.register(PlaylistsCollectionViewCell.nib, forCellWithReuseIdentifier: PlaylistsCollectionViewCell.identifier)
            viewModel = TagPlaylistsViewModel(tag, vc: self)
            collectionView.dataSource = viewModel
            if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                layout.itemSize = CGSize(width: collectionView.frame.width,
                                         height: PlaylistsCollectionViewCell.frameHeight)
            }
        }
    }
}
