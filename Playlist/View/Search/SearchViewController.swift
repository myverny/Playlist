//
//  SearchViewController.swift
//  Playlist
//
//  Created by DONGHYUN KIM on 2018. 7. 16..
//  Copyright © 2018년 dorenza. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet private weak var tagCollectionView: UICollectionView! {
        didSet {
            tagCollectionView.delegate = self
            tagCollectionView.dataSource = self
        }
    }
    
    private var firebaseConn: FirebaseConn!
    private var tags = [Tag]() {
        didSet {
            tagCollectionView.reloadData()
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = tagCollectionView.dequeueReusableCell(withReuseIdentifier: "search tag", for: indexPath)
        
        if let searchTagCell = cell as? SearchTagCollectionViewCell {
            searchTagCell.tagButton.setTagName(as: tags[indexPath.item].name)
        }
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let flowLayout = tagCollectionView.collectionViewLayout as? LeftAlignedCollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 1, height: 1)
        }
        firebaseConn = FirebaseConn()
        firebaseConn.getData(from: FirebaseConn.tagsPath) { snapshots in
            var tags = [Tag]()
            for snapshot in snapshots {
                if let tag = Tag.init(snapshot) {
                    tags.append(tag)
                }
            }
            self.tags = tags
        }
    }
    
}
