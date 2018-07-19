//
//  TagPlaylistsViewModel.swift
//  Playlist
//
//  Created by DONGHYUN KIM on 2018. 7. 18..
//  Copyright © 2018년 dorenza. All rights reserved.
//

import Foundation
import UIKit

class TagPlaylistsViewModel: NSObject, FirebaseConnDelegate {
    private var firebaseConn = FirebaseConn()
    private var playlistsTag: Tag!
    private var completion: CompletionHandler!
    var tags: [String : Tag]?
    var playlists: [String : Playlist]? {
        didSet {
            tagPlaylistsViewController.collectionView.reloadData()
        }
    }
    
    private weak var tagPlaylistsViewController: TagPlaylistsViewController!
    
    init(_ tag: Tag, vc: TagPlaylistsViewController) {
        super.init()
        playlistsTag = tag
        tagPlaylistsViewController = vc
        firebaseConn.getPlaylists(self)
    }
}

extension TagPlaylistsViewModel: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return playlistsTag.playlists.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlaylistsCollectionViewCell.identifier, for: indexPath) as? PlaylistsCollectionViewCell,
            let playlist = playlists?[playlistsTag.playlists[indexPath.row]],
            let imgUrl = playlist.imgUrl {
            cell.setUp(hideRank: true, rank: nil, title: playlist.title, desc: playlist.desc, imgUrl: imgUrl, videos: playlist.videos, vc: tagPlaylistsViewController)
            return cell
        }
        return UICollectionViewCell()
    }
}
