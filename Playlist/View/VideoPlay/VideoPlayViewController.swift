//
//  VideoPlayViewController.swift
//  Playlist
//
//  Created by dev on 2018. 7. 23..
//  Copyright © 2018년 dorenza. All rights reserved.
//

import UIKit
import youtube_ios_player_helper

class VideoPlayViewController: UIViewController {

    @IBOutlet weak var playView: YTPlayerView!
    
    var videoId: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        playView.load(withVideoId: videoId, playerVars: ["origin":"http://www.youtube.com"])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
