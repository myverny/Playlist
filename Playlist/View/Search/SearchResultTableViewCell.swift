//
//  SearchResultTableViewCell.swift
//  Playlist
//
//  Created by DONGHYUN KIM on 2018. 7. 16..
//  Copyright © 2018년 dorenza. All rights reserved.
//

import UIKit
import youtube_ios_player_helper

class SearchResultTableViewCell: UITableViewCell {

    @IBOutlet weak var ytpView: YTPlayerView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
