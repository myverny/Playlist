//
//  RankViewModel.swift
//  Playlist
//
//  Created by DONGHYUN KIM on 2018. 7. 19..
//  Copyright © 2018년 dorenza. All rights reserved.
//

import Foundation
import UIKit

class HomeViewModelRankViewModel: NSObject, UICollectionViewDelegate, UICollectionViewDataSource {
    private var item: HomeViewModelItem!
    
    init(_ item: HomeViewModelItem) {
        self.item = item
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let rankItem = item as? HomeViewModelRankItem {
            return rankItem.ranks.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let rankItem = item as? HomeViewModelRankItem,
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RankCollectionViewCell.identifier, for: indexPath) as? RankCollectionViewCell {
            let playlist = rankItem.ranks[indexPath.item]
            cell.rankLabel.text = String(indexPath.item)
            cell.titleLabel.text = playlist.title
            cell.descLabel.text = playlist.desc
            let imgUrl = playlist.imgUrl
            DispatchQueue.global().async() {
                let imageData = try? Data(contentsOf: imgUrl!)
                DispatchQueue.main.async() {
                    if imageData != nil, let image = UIImage(data: imageData!) {
                        cell.thumbnailImageView?.image = image
                    }
                }
            }
            
            return cell
        }
        return UICollectionViewCell()
    }
}
