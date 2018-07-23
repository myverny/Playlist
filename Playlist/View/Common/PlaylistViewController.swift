//
//  PlaylistViewController.swift
//  Playlist
//
//  Created by DONGHYUN KIM on 2018. 7. 19..
//  Copyright © 2018년 dorenza. All rights reserved.
//

import UIKit

class PlaylistViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var videos: [String]!
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.register(PlaylistTableViewCell.nib, forCellReuseIdentifier: PlaylistTableViewCell.identifier)
            tableView.estimatedRowHeight = 130
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: PlaylistTableViewCell.identifier, for: indexPath) as? PlaylistTableViewCell {
            cell.setUp(videoId: videos[indexPath.row], vc: self)
            return cell
        }
        return UITableViewCell()
    }
    
}
