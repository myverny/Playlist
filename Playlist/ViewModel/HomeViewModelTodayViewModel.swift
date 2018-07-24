//
//  HomeViewModelTodayViewModel.swift
//  Playlist
//
//  Created by dev on 2018. 7. 19..
//  Copyright © 2018년 dorenza. All rights reserved.
//

import Foundation
import UIKit

class HomeViewModelTodayViewModel: NSObject, UICollectionViewDataSource {
    private var item: HomeViewModelItem!
    private var base: HomeViewModel!
    private weak var vc: UIViewController!
    
    init(_ item: HomeViewModelItem, base: HomeViewModel, vc: UIViewController) {
        self.item = item
        self.base = base
        self.vc = vc
    }
  
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        if let todayItem = item as? HomeViewModelTodayItem {
            return (todayItem.playlist?.tags.count)!
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let todayItem = item as? HomeViewModelTodayItem,
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCollectionViewCell.identifier, for: indexPath) as? TagCollectionViewCell,
            let tagId = todayItem.playlist?.tags[indexPath.item],
            let tag = base.tags?[tagId] {
                cell.setUp(tag: tag, vc: vc)
            return cell
        }
        return UICollectionViewCell()
    }
}

extension HomeViewModelTodayViewModel: HomeViewCellDelegate {
    func touchCell(sender: UITapGestureRecognizer) {
        let storyboard = UIStoryboard(name: "Playlist", bundle: nil)
        if let pvc = storyboard.instantiateInitialViewController() as? PlaylistViewController,
            let todayItem = item as? HomeViewModelTodayItem {
            pvc.videos = todayItem.playlist?.videos
            vc.show(pvc, sender: sender)
        }
    }
}
