//
//  PlaylistTableViewCell.swift
//  Playlist
//
//  Created by DONGHYUN KIM on 2018. 7. 19..
//  Copyright © 2018년 dorenza. All rights reserved.
//

import UIKit
import youtube_ios_player_helper

class PlaylistTableViewCell: UITableViewCell {

    @IBOutlet private weak var ytpView: YTPlayerView!
    
    private var videoId: String!
    
    func setUp(videoId: String) {
        self.videoId = videoId
        ytpView.load(withVideoId: videoId)
    }
    
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
}
