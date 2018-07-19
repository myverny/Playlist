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
            tagPlaylistsViewController.tableView.reloadData()
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

extension TagPlaylistsViewModel: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playlistsTag.playlists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: TodayTableViewCell.identifier, for: indexPath) as? TodayTableViewCell,
            let playlist = playlists?[playlistsTag.playlists[indexPath.row]],
            let imgUrl = playlist.imgUrl {
            cell.setUp(title: playlist.title, desc: playlist.desc, imgUrl: imgUrl, screenSize: tableView.bounds)
            return cell
        }
        return UITableViewCell()
    }
}
