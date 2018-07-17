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
    private var tags = [Any]() {
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
        
        if let searchTagCell = cell as? SearchTagCollectionViewCell,
            let tagInfo = tags[indexPath.item] as? [String:Any],
            let tagName = tagInfo["tag"] as? String {
            searchTagCell.setTagName(as: tagName)
        }
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let flowLayout = tagCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 1, height: 1)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        firebaseConn = FirebaseConn()
        firebaseConn.getDataRef().child("tags").observe(.value) { (snapshot) in
            if let tagSnapshot = snapshot.value as? [Any] {
                self.tags = tagSnapshot
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        firebaseConn.getDataRef().removeAllObservers()
    }

}
