//
//  SearchViewController.swift
//  Playlist
//
//  Created by DONGHYUN KIM on 2018. 7. 16..
//  Copyright © 2018년 dorenza. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UICollectionViewDataSource, FirebaseConnDelegate {
    var playlists: [String:Playlist]?
    var tags: [String:Tag]? {
        didSet {
            tagCollectionView.reloadData()
        }
    }
    
    @IBOutlet private weak var tagCollectionView: UICollectionView! {
        didSet {
            tagCollectionView.dataSource = self
        }
    }
    
    private var firebaseConn: FirebaseConn!
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tags?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = tagCollectionView.dequeueReusableCell(withReuseIdentifier: "search tag", for: indexPath)
        
        if let searchTagCell = cell as? SearchTagCollectionViewCell,
            let tag = tags?[String(indexPath.item)] {
            searchTagCell.tagButton.setTagName(as: tag)
            searchTagCell.tagButton.vc = self
        }
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let flowLayout = tagCollectionView.collectionViewLayout as? LeftAlignedCollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 1, height: 1)
        }
        firebaseConn = FirebaseConn()
        firebaseConn.getTags(self)
    }
    
}
