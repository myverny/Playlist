//
//  SearchViewController.swift
//  Playlist
//
//  Created by DONGHYUN KIM on 2018. 7. 16..
//  Copyright © 2018년 dorenza. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var tagCollectionView: UICollectionView! {
        didSet {
            tagCollectionView.delegate = self
            tagCollectionView.dataSource = self
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = tagCollectionView.dequeueReusableCell(withReuseIdentifier: "search tag", for: indexPath)
        
        if let searchTagCell = cell as? SearchTagCollectionViewCell {
            searchTagCell.setTagName(as: "비트코인")
        }
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let flowLayout = tagCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 1, height: 1)
        }
    }

}
