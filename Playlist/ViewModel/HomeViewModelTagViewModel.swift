//
//  HomeViewModelTagViewMdoel.swift
//  Playlist
//
//  Created by dev on 2018. 7. 24..
//  Copyright © 2018년 dorenza. All rights reserved.
//

import Foundation

//
//  HomeViewModelTodayViewModel.swift
//  Playlist
//
//  Created by dev on 2018. 7. 19..
//  Copyright © 2018년 dorenza. All rights reserved.
//

import Foundation
import UIKit

class HomeViewModelTagViewModel: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
    private var item: HomeViewModelTagItem!
    private var base: HomeViewModel!
    private weak var vc: UIViewController!
    
    init(_ item: HomeViewModelItem, base: HomeViewModel, vc: UIViewController) {
        self.item = item as! HomeViewModelTagItem
        self.base = base
        self.vc = vc
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return item.tags[collectionView.tag].playlists.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagTableCollectionViewCell.identifier, for: indexPath) as? TagTableCollectionViewCell {
            let playlistId = item.tags[collectionView.tag].playlists[indexPath.item]
            guard let playlist = base.playlists![playlistId] else {
                return UICollectionViewCell()
            }
            cell.setUp(title: playlist.title, desc: playlist.desc, imgUrl: playlist.imgUrl!,
                       viewCount: playlist.viewCount, bookmarkCount: playlist.bookmarkCount)
            return cell
        }
        return UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Playlist", bundle: nil)
        if let pvc = storyboard.instantiateInitialViewController() as? PlaylistViewController {
            let playlistId = item.tags[collectionView.tag].playlists[indexPath.item]
            guard let playlist = base.playlists![playlistId] else {
                return
            }
            pvc.videos = playlist.videos
            vc.show(pvc, sender: vc)
        }
    }
    /*
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

    }*/
}


