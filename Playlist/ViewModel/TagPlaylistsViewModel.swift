//
//  TagPlaylistsViewModel.swift
//  Playlist
//
//  Created by DONGHYUN KIM on 2018. 7. 18..
//  Copyright © 2018년 dorenza. All rights reserved.
//

import Foundation
import UIKit

class TagPlaylistsViewModel: NSObject {
    private var firebaseConn = FirebaseConn()
    private var playlistsTag: Tag?
    private var completion: CompletionHandler!
    private var playlists = [Playlist]() {
        didSet {
            tagPlaylistsViewController.tableView.reloadData()
        }
    }
    private weak var tagPlaylistsViewController: TagPlaylistsViewController!
    
    init(_ tag: Tag, vc: TagPlaylistsViewController) {
        super.init()
        playlistsTag = tag
        tagPlaylistsViewController = vc
        prepareData()
    }
    
    private func prepareData() {
        firebaseConn.getData(from: FirebaseConn.playlistsPath) { [weak self] snapshots in
            var playlists = [Playlist]()
            for snapshot in snapshots {
                if let playlist = Playlist.init(snapshot) {
                    if self?.playlistsTag?.playlists.index(of: playlist.id) != nil {
                        playlists.append(playlist)
                    }
                }
            }
            self?.playlists = playlists
        }
    }
}

extension TagPlaylistsViewModel: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playlists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: TodayTableViewCell.identifier, for: indexPath) as? TodayTableViewCell {
            let playlist = playlists[indexPath.row]
            cell.titleLabel?.text = playlist.title
            cell.descLabel?.text = playlist.desc
            
            if let imgUrl = playlist.imgUrl {
                DispatchQueue.global().async() {
                    let imageData = try? Data(contentsOf: imgUrl)
                    DispatchQueue.main.async {
                        if imageData != nil, let image = UIImage(data: imageData!) {
                            cell.thumbnailImageView?.image = image
                            let screenSize = tableView.bounds
                            cell.thumbnailImageView?.frame.size.width = screenSize.width
                            cell.thumbnailImageView?.frame.size.height = screenSize.width / image.size.width * image.size.height
                        }
                    }
                }
            }
            return cell
        }
        return UITableViewCell()
    }
}
