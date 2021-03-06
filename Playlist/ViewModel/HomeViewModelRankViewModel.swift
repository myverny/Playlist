//
//  RankViewModel.swift
//  Playlist
//
//  Created by DONGHYUN KIM on 2018. 7. 19..
//  Copyright © 2018년 dorenza. All rights reserved.
//

import Foundation
import UIKit

class HomeViewModelRankViewModel: NSObject, UICollectionViewDataSource {
    private var item: HomeViewModelItem!
    
    init(_ item: HomeViewModelItem, vc: UIViewController) {
        self.item = item
        self.vc = vc
    }
    
    private weak var vc: UIViewController!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let rankItem = item as? HomeViewModelRankItem {
            return rankItem.ranks.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let rankItem = item as? HomeViewModelRankItem,
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlaylistsCollectionViewCell.identifier, for: indexPath) as? PlaylistsCollectionViewCell {
            let playlist = rankItem.ranks[indexPath.item]
            if let imgUrl = playlist.imgUrl {
                cell.setUp(hideRank: false, rank: String(indexPath.item + 1), title: playlist.title, desc: playlist.desc, imgUrl: imgUrl, videos: playlist.videos, vc: vc)
            }
            return cell
        }
        return UICollectionViewCell()
    }
}
